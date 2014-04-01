

#' Valid latitude
#'
#' Test for valid latitude. Between -90 and 90
#' @param x A latitude
#' @export
#' @examples \dontrun{
#' expect_true(test_lat(dat$latitude))
#'}
test_lat <- function(x) {
	value <- sapply(x, function(y) y < -90 | y > 90)
	if(any(value))  {
		FALSE
	} else {
		TRUE
	}
}


#' Valid longitude
#'
#' Test for valid longitude. Between -180 and 180
#' @param x A longitude
#' @export
#' @examples \dontrun{
#' expect_true(test_lat(dat$longitude))
#'}
test_long <- function(x) {
	value <- sapply(x, function(y) y < -180 | y > 180)
	if(any(value))  {
		FALSE
	} else {
		TRUE
	}
}


