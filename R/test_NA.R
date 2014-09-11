#' Test for cryptic NAs
#'
#' This test will check every column in a data.frame for possible missing value codes.
#' A list of missing value codes to check can be found in White et al. 2013.
#' @param dat input dataset. Currently only supports \code{data.frame} but will soon support \code{data.table}
#' @export
#' @references 2 Ethan P. White, Elita Baldridge, Zachary T. Brym, Kenneth J. Locey, Daniel J. McGlinn, and 3 and Sarah R. Supp.  1 Nine simple ways to make it easier to (re)use your data.  PeerJ PrePrints. , doi: 10.7287/peerj.preprints.7v2
test_for_NA <- function(dat) {
  if (!is(dat, "data.frame")) {
    stop("Can only test data.frames at this time")
  }
  message(sprintf("Now checking %s columns...", ncol(dat)))
  
  # List is incomplete
  NA_aliases = list(
    "missing", 
    "no data", 
    "-999",
    "999",
    -999,
    999,
    NULL,
    "na",
    "N/A",
    "n/a",
    "NULL"
  )
  
  # Should also do regexes to include other capitalizations
  matches = is.na(dat) | sapply(dat, function(x){x %in% NA_aliases})
  
  # throw a warning if 999 is identified as an NA alias
  if(sum(dat[matches] %in% list("-999", "999", -999, 999))){
    message("999 was identified as a possible NA alias -- please verify this is not a data value!")
  }
  
  return(data.frame(
    row = row(dat)[matches], 
    column = col(dat)[matches], 
    value = dat[matches],
    stringsAsFactors = FALSE
  ))
} 

#noRd
#' @export
test_NA <- function(...) {
  z <- test_for_NA(...)
  return(ifelse(nrow(z) ==0, TRUE, FALSE))
}


#noRd
#' @export
find_NA <- function(...) {
  z <- test_for_NA(...)
  return(z)
}
 