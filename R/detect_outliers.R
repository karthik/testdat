#' Functions to import: scores from outliers package
#' 
#' @import outliers
#' @export 
#' @param dat data.frame input
#' @param threshold Threshold value
#' @param ... Further args
#' @return Returns an index with outliers to investigate

detect_outliers <- function(dat, threshold = 1.5, ...){
  
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


