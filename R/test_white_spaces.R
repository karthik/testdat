#' test_for_white_spaces
#'
#' Tests white spaces that could end up padding text
#' @param text Input text. Usually this would be a \code{character} field.
#' @export
#' @examples \dontrun{
#' test_white_spaces(" Karthik Ram")
#' test_white_spaces(" Karthik Ram ")
#'}
test_white_spaces <- function (text)  
{   wsDetected <- FALSE
    text1 <- sub("^ +", "", text)
    if (text1 != text) wsDetected <- TRUE
    text2 <- sub(" +$", "", text)
    if (text2 != text) wsDetected <- TRUE
    if (wsDetected) return TRUE
    else return FALSE
}
