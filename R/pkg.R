#' @title Read in SAS datasets (.sas7bdat files) into Spark
#' @description 'spark.sas7bdat' uses the spark-sas7bdat Spark package to load SAS dataset in parallel in Spark.
#' @name spark.sas7bdat-package 
#' @aliases spark.sas7bdat-package
#' @docType package 
#' @importFrom sparkapi hive_context invoke spark_dependency register_extension
#' @importFrom sparklyr sdf_register
#' @importFrom magrittr "%>%"
NULL
