

#' Valid latitude
#'
#' Test for valid latitude. Between -90 and 90
#' @param x A latitude
#' @export
#' @examples \dontrun{
#' expect_true(test_lat(dat$latitude))
#'}
test_lat <- function(x) {
 all(x > -90 & x < 90)
}


#' Valid longitude
#' Test for valid longitude. Between -180 and 180
#' @param x A longitude
#' @export
#' @examples \dontrun{
#' expect_true(test_lat(dat$longitude))
#'}
test_long <- function(x) {
 all(x > -180 & x < 180)
}


