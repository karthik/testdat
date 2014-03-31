#' Test for outliers
#'
#' This function identifies numeric columns in a data.frame, then identifies outliers and returns the indexes of these possible outliers for each numeric column.
#' @param dat input dataset. Currently only supports \code{data.frame} but will soon support \code{data.table}
#' @param threshold for outlier detection method (defaults to z-score)
#' @param ... Further args (to be passed to scores() function)
#' @export
#' @importFrom outliers scores
#' @examples \dontrun{
#' data(iris)
#' detect_outliers(iris)
#'}
detect_outliers <- function(dat, threshold = 1.96, ...){
  
  # identify numeric columns
  ind <- which(sapply(dat, is.numeric))
  
  # create list for results  
  res <- vector(mode="list", length=length(ind))
  names(res) <- names(ind)
  
  # populate list with outliers for each numeric column
  for(i in 1:length(ind)){
    
    # identify outliers
    tmp <- which(scores(dat[,ind[i]]) >= threshold, ...)
    
    # put into results list
    res[[i]] <- tmp
    
    if(length(tmp)==0){
      message(paste("no outliers for variable \""),names(ind[i]),"\"")
    }
    else{
      message(paste(length(tmp),"outlier(s) for variable \""),names(ind[i]),"\"")
    }
  }
  
  message("Below are indexes of outliers to investigate")
  
  # return results list
  return(res)
  
}

