#' @title Read in SAS datasets (.sas7bdat files) into Spark
#' @description 'spark.sas7bdat' uses the spark-sas7bdat Spark package to process SAS datasets in parallel using Spark. Hereby allowing to execute dplyr statements on top of SAS datasets.
#' @name spark.sas7bdat-package 
#' @aliases spark.sas7bdat-package
#' @docType package 
#' @importFrom sparklyr hive_context invoke spark_dependency register_extension sdf_register
NULL
