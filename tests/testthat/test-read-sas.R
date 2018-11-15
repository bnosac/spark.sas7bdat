context("test-read-sas")

test_that("spark_read_sas", {
  require(sparklyr)
  require(spark.sas7bdat)
  require(dplyr)
  
  myfile <- system.file("extdata", "iris.sas7bdat", package = "spark.sas7bdat")
  
  testthat::expect_is(sc <- spark_connect(master = "local"), "spark_connection" )
  testthat::expect_is(x <- spark_read_sas(sc, path = myfile, table = "sas_example"), "tbl_spark")
  testthat::expect_is(
    x %>% dplyr::group_by(Species) %>%
      dplyr::summarise(
        count = n(),
        length = mean(Sepal_Length, na.rm = TRUE),
        width = mean(Sepal_Width, na.rm = TRUE)
      ),
    "tbl_spark")
  sparklyr::spark_disconnect(sc)
})