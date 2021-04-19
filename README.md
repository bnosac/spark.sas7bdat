# spark.sas7bdat

The  **spark.sas7bdat** package allows R users working with [Apache Spark](https://spark.apache.org) to read in [SAS](https://www.sas.com) datasets in .sas7bdat format into Spark by using the [spark-sas7bdat Spark package](https://spark-packages.org/package/saurfang/spark-sas7bdat). This allows R users to 

- load a SAS dataset in parallel into a Spark table for further processing with the [sparklyr](https://cran.r-project.org/package=sparklyr) package
- process in parallel the full SAS dataset with dplyr statements, instead of having to import the full SAS dataset in RAM (using the foreign/haven packages) and hence avoiding RAM problems of large imports


## Example
The following example reads in a file called iris.sas7bdat in a table called sas_example in Spark. Do try this with bigger data on your cluster and look at the help of the [sparklyr](https://github.com/sparklyr/sparklyr) package to connect to your Spark cluster.

```r
library(sparklyr)
library(spark.sas7bdat)
mysasfile <- system.file("extdata", "iris.sas7bdat", package = "spark.sas7bdat")

sc <- spark_connect(master = "local")
x <- spark_read_sas(sc, path = mysasfile, table = "sas_example")
x
```

The resulting pointer to a Spark table can be further used in dplyr statements
```r
library(dplyr)
x %>% group_by(Species) %>%
  summarise(count = n(), length = mean(Sepal_Length), width = mean(Sepal_Width))
```

## Installation

Install the package from CRAN.
```
install.packages('spark.sas7bdat')
```

Or install this development version from github.
```
devtools::install_github("bnosac/spark.sas7bdat", build_vignettes = TRUE)
vignette("spark_sas7bdat_examples", package = "spark.sas7bdat")
```

The package has been tested out with Spark version 2.0.1 and Hadoop 2.7.
```
library(sparklyr)
spark_install(version = "2.0.1", hadoop_version = "2.7")
```

## Speed comparison

In order to compare the functionality to the read_sas function from the [haven](https://cran.r-project.org/package=haven) package, below we show a comparison on a small 5234557 rows x 2 columns SAS dataset with only numeric data. Processing is done on 8 cores. With the haven package you need to import the data in RAM, with the spark.sas7bdat package, you can immediately execute dplyr statements on top of the SAS dataset.

```r
mysasfile <- "/home/bnosac/Desktop/testdata.sas7bdat"
system.time(x <- spark_read_sas(sc, path = mysasfile, table = "testdata"))
   user  system elapsed 
  0.008   0.000   0.051 
system.time(x <- haven::read_sas(mysasfile))
   user  system elapsed 
  1.172   0.032   1.200 
```

## Support in big data and Spark analysis

Need support in big data and Spark analysis?
Contact BNOSAC: http://www.bnosac.be

