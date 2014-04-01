#' Correct for cryptic NAs
#'
#' This function will correct every column in a data.frame for possible missing value codes. It should be used if the \code{test_NA()} function identifies cryptic NAs in your data.frame, or if you have a custom NA indicator that you want to correct.
#' A list of missing value codes to check can be found in White et al. 2013.
#' @param dat input dataset. Currently only supports \code{data.frame} but will soon support \code{data.table}
#' @param custom_NAs addition NA aliases you want to correct. Be sure to create a list if you want to include NA aliases of different classes.
#' @param removeFactors Should columns be converted from factors after correcting for NA aliases? (Conversion to factors happens by default in correction process.) Strongly recomment the TRUE default.
#' @export
#' @references 2 Ethan P. White, Elita Baldridge, Zachary T. Brym, Kenneth J. Locey, Daniel J. McGlinn, and 3 and Sarah R. Supp.  1 Nine simple ways to make it easier to (re)use your data.  PeerJ PrePrints. , doi: 10.7287/peerj.preprints.7v2
correct_NA <- function(dat, custom_NAs = list(), removeFactors=TRUE) {
  if (!is(dat, "data.frame")) {
    stop("Can only correct data.frames at this time")
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
  
  # append user-inputted custom_NAs
  
  if(length(custom_NAs)>0){
    NA_aliases <- append(NA_aliases,custom_NAs)
  }
  
  # Should also do regexes to include other capitalizations
  matches = is.na(dat) | sapply(dat, function(x){x %in% NA_aliases})
  
  if(sum(matches)==0){
    stop("This data.frame has no identifiable NA aliases.")
  }
  
  dat[matches] <- NA
  
  # removing factors, coercing into characters or numeric
  if(removeFactors==TRUE){
    
    # which columns to check
    check_col <- unique(col(dat)[matches])
    
    # how many NAs should there be?
    NAs_col <- apply(matches,2,sum)[check_col]
    
    for(i in 1:length(check_col)){
      
      # does coercing to numeric cause extra NAs? if not, then coerce to numeric
      # if so, coerce to character
      
      # no--coerce to numeric
      if(sum(is.na(suppressWarnings(as.numeric(as.character(dat[,check_col[i]])))))==NAs_col[i]){
        dat[,check_col[i]] <- as.numeric(as.character(dat[,check_col[i]]))
      }
      # yes--coerce to character
      else{
        dat[,check_col[i]] <- as.character(dat[,check_col[i]])
      }
    }
  }
  return(dat)
} 