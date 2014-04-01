#' sanitize_text
#'
#' Removes UTF8 characters from text columns
#' @param input_text The input text
#' @export
#' @importFrom assertthat assert_that
#' @examples \dontrun{
#' sanitize_text("This is some bad text \U3e32393cs that contains utf-8 characters")
#'}
sanitize_text <- function(input_text) {
  assert_that(is.character(input_text))
  sanitize.each.element <- function(elem) {
    if (Encoding(elem) == "unknown")
      enc <- "ASCII"
    else
      enc <- Encoding(elem)

    iconv(elem, from=enc, to="ASCII", sub="")
  }
  input_text <- sapply(input_text, sanitize.each.element)
  names(input_text) <- NULL
  input_text
}
