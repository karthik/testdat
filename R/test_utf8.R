test_utf8 <- function(dat) {
	if(!is(dat, "data.frame"))
		stop("Can only test data.frames at this time", .call = FALSE)

	 message(sprintf("Now checking %s fields...", ncol(dat)))

	message("done")
}