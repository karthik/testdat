
#' remove_white_spaces
#'
#' Removes white spaces that could end up padding text
#' @param text Input text. Usually this would be a \code{character} field.
#' @export
#' @examples \dontrun{
#' remove_white_spaces(" Karthik Ram")
#' remove_white_spaces(" Karthik Ram ")
#'}
remove_white_spaces <- function (text)
{
    text <- sub("^ +", "", text)
    text <- sub(" +$", "", text)
    text
}


