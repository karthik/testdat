#' Test for duplicate column names
#'
#' This test will check to see that there are no duplicate column names in a data frame.
#' Will return \code{TRUE} if there is a duplicate column name, otherwise \code{FALSE}.
#' @param dat input dataset. Currently only supports \code{data.frame}.
#' @export
test_dupname <- function(dat) {
  return(!(length(unique(colnames(dat))) == length(colnames(dat))))
}