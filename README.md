[![Build Status](https://travis-ci.org/ropensci/testdat.svg)](https://travis-ci.org/ropensci/testdat)

# testdat!

This package provides a test suite to ensure that tabular data are correctly formatted. It will ensure that columns do not have unicode characters, numeric columns don't have characters, and that columns of data can be tested to ensure that there are no outliers. This suite would be extremely useful alongside unit tests for code to ensure that data read into R do not have errors in them.


## Installation

```coffee
library(devtools)
# if you don't have the package, run install.packages("devtools")
install_github("ropensci/testdat")
```


## Use Cases

The `testdat` package has two types of functions -- those to test for errors in data.frames, and those to correct for these errors in data.frames.

The testing suite of functions should be used immediately after loading a data.frame into R. These functions are prepended with `test`. This suite has two goals -- first, it allows you as a user to immediately identify potential issues with the data. Second, it functions to communiate to readers of your analysis that you investigated errors in your data. One possible usecase, then, is to print the results of these tests in your analysis or documentation immediately after loading the data.

```coffee
> data <- read.csv(system.file("extdata", "2012.csv", package="testdat"))
> test_utf8(data)
[1] FALSE
```

The correcting suite of functions should be used in the case that the testing suite of functions elucidate issues with your data. These functions are prepended with `fix`. Not every testing function has a correction function -- for example, a correction function for `test_outliers.R` would have serious statistical implications. However, for functions such as `test_utf8.R`, we have included a `fix_utf8.R` function for a quick fix to a negative test.

```coffee
> filename <- system.file("extdata", "km1314-waypoints.csv", package="testdat")
> data <- read.csv(filename, header=FALSE)
> test_utf8(data)
[1] TRUE
> clean_data <- fix_utf8(data)
> test_utf8(clean_data)
[1] FALSE
```
(Note the above is just pseudocode until we get these functions working.)

Using the `testdat` suite of functions allows you to create a convincing argument that you have properly dealt with data quality issues, in a way that is easily followed by readers of your analysis. Presenting these tests and corrections in documentation adds reproducibility to the way that you identified and corrected errors, or verifying that your data did not have errors.

## Examples

### Testing for outliers

### Testing/Fixing for continuous dates

### Testing/Fixing whitespaces

### Testing/Fixing utf8 characters

### Testing/Fixing NAs

```coffee
dat <- data.frame(
  date = rep(as.Date("2014-01-01"),10),
  num = c(1:8,999,"n/a"),
  name = c("NULL","naa",rep("foo",8))
)

dat
test_NA(dat)
class(dat$num)
class(dat$name)
clean_dat <- fix_NA(dat, custom_NAs="naa")
clean_dat
class(clean_dat$num)
class(clean_dat$name)
```

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
