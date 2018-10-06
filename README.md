meta_cobecore
=======

A programmatic shiny interface to annotate meta-data from digitized data records in R.

Installation
------------

To install the development releases of the package run the following commands:

``` r
if(!require(devtools)){install.package("devtools")}
devtools::install_github("khufkens/meta_cobecore")
library("meta_cobecore")
```

Use
---

To start the shiny web interface use the following command, where the path variable points to the location of the images you want to annotate. The meta-data you provide is incrementally added to a file called **meta_data.csv saved at the same location**.

``` r
meta_cobecore(path = "/the/location/of/your/images/")
```

Acknowledgements
----------------

This project was supported by the Belgian Science Policy Office (BELSPO) contract number BR/175/A3/COBECORE.