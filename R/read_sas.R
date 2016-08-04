
#' @title Read in SAS datasets in .sas7bdat format into Spark by using the spark-sas7bdat Spark package.
#' @description Read in SAS datasets in .sas7bdat format into Spark by using the spark-sas7bdat Spark package.
#' @param sc Connection to Spark local instance or remote cluster. See the example
#' @param path full path to the SAS file either on HDFS (hdfs://), S3 (s3n://), as well as the local file system (file://). 
#' Mark that files on the local file system need to be specified using the full path.
#' @param table character string with the name of the Spark table where the SAS dataset will be put into
#' @return an object of class \code{tbl_spark}, which is a reference to a Spark DataFrame based on which
#' dplyr functions can be executed. See \url{https://github.com/rstudio/sparklyr}
#' @export
#' @seealso \code{\link[sparklyr]{start_shell}}, \code{\link[sparklyr]{sdf_register}}
#' @references \url{https://spark-packages.org/package/saurfang/spark-sas7bdat}, \url{https://github.com/saurfang/spark-sas7bdat}, \url{https://github.com/rstudio/sparklyr}
#' @examples
#' \dontrun{
#' myfile <- system.file("extdata", "iris.sas7bdat", package = "spark.sas7bdat")
#' myfile
#' 
#' library(sparklyr)
#' library(spark.sas7bdat)
#' sc <- spark_connect(master = "local")
#' x <- spark_read_sas(sc, path = myfile, table = "sas_example")
#' x
#' }
spark_read_sas <- function(sc, path, table){
  if(missing(table)){
    stop("Please provide the name of the Spark table where to store the SAS file into")
  }
  x <- hive_context(sc) %>% invoke("read") %>% invoke("format", "com.github.saurfang.sas.spark") %>% invoke("load", path)
  sdf <- sdf_register(x, name = table)
  sdf
}





spark_dependencies <- function(scala_version, ...) {
  sparklyr::spark_dependency(
    packages = c(
      sprintf("saurfang:spark-sas7bdat:1.1.4-s_%s", scala_version)
    )
  )
}
.onLoad <- function(libname, pkgname) {
  sparklyr::register_extension(pkgname)
}
