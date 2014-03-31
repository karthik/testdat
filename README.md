# test dat!

This package provides a test suite to ensure that tabular data are correctly formatted. It will ensure that columns do not have unicode characters, numeric columns don't have characters, and that columns of data can be tested to ensure that there are no outliers. This suite would be extremely useful alongside unit tests for code to ensure that data read into R do not have errors in them.


## Installation

```coffee
library(devtools)
# if you don't have the package, run install.packages("devtools")
install_github("ropensci/testdat")
```



