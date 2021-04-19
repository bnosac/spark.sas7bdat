
#' @title Read in SAS datasets in .sas7bdat format into Spark by using the spark-sas7bdat Spark package.
#' @description Read in SAS datasets in .sas7bdat format into Spark by using the spark-sas7bdat Spark package.
#' @param sc Connection to Spark local instance or remote cluster. See the example
#' @param path full path to the SAS file either on HDFS (hdfs://), S3 (s3n://), as well as the local file system (file://). 
#' Mark that files on the local file system need to be specified using the full path.
#' @param table character string with the name of the Spark table where the SAS dataset will be put into
#' @return an object of class \code{tbl_spark}, which is a reference to a Spark DataFrame based on which
#' dplyr functions can be executed. See \url{https://github.com/sparklyr/sparklyr}
#' @export
#' @seealso \code{\link[sparklyr]{spark_connect}}, \code{\link[sparklyr]{sdf_register}}
#' @references \url{https://spark-packages.org/package/saurfang/spark-sas7bdat}, \url{https://github.com/saurfang/spark-sas7bdat}, \url{https://github.com/sparklyr/sparklyr}
#' @examples
#' \dontrun{
#' ## If you haven't got a Spark cluster, you can install Spark locally like this
#' library(sparklyr)
#' spark_install(version = "2.0.1")
#' 
#' ## Define the SAS .sas7bdat file, connect to the Spark cluster to read + process the data
#' myfile <- system.file("extdata", "iris.sas7bdat", package = "spark.sas7bdat")
#' myfile
#' 
#' library(spark.sas7bdat)
#' sc <- spark_connect(master = "local")
#' x <- spark_read_sas(sc, path = myfile, table = "sas_example")
#' x
#' 
#' library(dplyr)
#' x %>% group_by(Species) %>%
#'   summarise(count = n(), length = mean(Sepal_Length), width = mean(Sepal_Width))
#' }
spark_read_sas <- function(sc, path, table){
  if(missing(table)){
    stop("Please provide the name of the Spark table where to store the SAS file into")
  }
  x <- hive_context(sc)
  x <- invoke(x, "read")
  x <- invoke(x, "format", "com.github.saurfang.sas.spark")
  x <- invoke(x, "load", path)
  sdf <- sdf_register(x, name = table)
  sdf
}

spark_dependencies <- function(spark_version, scala_version, ...) {
  sparklyr::spark_dependency(
    packages = c(
      sprintf("saurfang:spark-sas7bdat:2.0.0-s_%s", scala_version)
    )
  )
}
.onLoad <- function(libname, pkgname) {
  sparklyr::register_extension(pkgname)
}
