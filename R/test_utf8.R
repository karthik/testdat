#' Test for UTF-8 characters
#'
#' This test will check every column in a data.frame for possible unicode characters.
#' @param dat input dataset. Currently only supports \code{data.frame} but will soon support \code{data.table}
#' @export
#' @importFrom stringr str_c
#' @examples \dontrun{
#' data(iris)
#' test_utf8(iris)
#' temp <- structure(list(x = 'The\U3e32393cs quick brown fox jumps over the \U3e32393cs the lazy dog', y = 'Lorem\U3e32393cs ipsum \U3e32393cs dolor', dat = 43.5), .Names = c('x', 'y', 'dat'), row.names = c(NA, -1L), class = 'data.frame')
#' test_utf8(temp)
#'}
test_utf8 <- function(dat, verbose = F) {
    if (!is(dat, "data.frame")) {
        stop("Can only test data.frames at this time")
    }
    if(verbose) message(sprintf("Now checking %s columns...", ncol(dat)))
    # Testing for UTF-8 in any columns
    ut8 <- suppressWarnings(apply(dat, 2, non_ascii))
    if(any(ut8) == TRUE) {
        if(verbose) {
        message("UTF-8 characters detected in columns ")
        message(sprintf("%s", paste0(as.character(which(ut8)), collapse = " ")))
        }
        TRUE
    } else {
        FALSE
    }

} 


#'@noRd
non_ascii <- function(x) {
  any(charToRaw(x) > 0x7F)
}


# Test
# Set the working directory to the package root
#  data <- read.csv("local/km1314-waypoints.csv")
#  test_utf8(data)
# 
