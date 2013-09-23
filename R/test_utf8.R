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
test_utf8 <- function(dat) {
    if (!is(dat, "data.frame")) {
        stop("Can only test data.frames at this time")
    }
    message(sprintf("Now checking %s columns...", ncol(dat)))
    # Testing for UTF-8 in any columns
    ut8 <- apply(dat, 2, Encoding)
    if (any(ut8 == "UTF-8")) {
        pos <- str_c(as.character(which(ut8 == "UTF-8")), collapse = " ")
        message(sprintf("UTF-8 characters detected in columns %s", pos))
    }
    message("done")
} 
