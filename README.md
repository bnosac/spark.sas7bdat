# spark.sas7bdat

The  **spark.sas7bdat** package allows R users working with [Apache Spark](https://spark.apache.org) to read in [SAS](http://www.sas.com) datasets in .sas7bdat format into Spark by using the [spark-sas7bdat Spark package](https://spark-packages.org/package/saurfang/spark-sas7bdat). This allows R users to load a SAS dataset in parallel into a Spark table.


## Example
The following example reads in a file called iris.sas7bdat in parallel in the a table called sas_example in Spark. Do try this with bigger data on your cluster.

```
library(spark.sas7bdat)
library(sparklyr)
mysasfile <- system.file("extdata", "iris.sas7bdat", package = "spark.sas7bdat")

sc <- spark_connect(master = "local")
x <- spark_read_sas(sc, path = mysasfile, table = "sas_example")
x
```

The resulting pointer to a Spark table can be further used in dplyr statements
```
library(dplyr)
library(magrittr)
x %>% group_by(Species) %>%
  summarise(count = n(), length = mean(Sepal_Length), width = mean(Sepal_Width))
```


## Installation

```
devtools::install_github("bnosac/spark.sas7bdat", build_vignettes = TRUE)
vignette("spark_sas7bdat_examples", package = "spark.sas7bdat")
```


## Support in big data and Spark analysis

Need support in big data and Spark analysis?
Contact BNOSAC: http://www.bnosac.be

