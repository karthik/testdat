#' Test for date continuity
#' 
#' Determine whether date column contains a continuous range of times
#' 
#' @param dat data frame to test
#' @param index index of column containing dates
#' @param form a lubridate function giving the format the dates should be in
#' @param granularity how often are measurements expected? defaults to \code{'days'}.
#' @import lubridate
#' @return returns at least some of the missing dates (measured in \code{granularity}) if there are any, otherwise returns TRUE
#' @details by "some of" the missing dates, we mean the function returns the first [\code{granularity}] after the one present in the dataset. However, more than just the first unit might be missing.
#' @export
test_continuous_date = function(dat, index, form=ymd, granularity='days'){
    granularity = match.arg(granularity, c('secs', 'mins', 'hours', 'days', 'weeks', 'years'))

    # first test validity, and stop if dates aren't formatted right:
    message('testing date column...')
    stopifnot(test_datecol(dat, index, form))
    message('test passed.')

    # then sort dates and make sure they are a range:
    ordered_dates = sort(form(dat[,index]))
    l = length(ordered_dates)
    if(granularity != 'years'){
        diffs = difftime(ordered_dates[-1], ordered_dates[-l], units=granularity)
    }else{
        diffs = year(ordered_dates[-1]) - year(ordered_dates[-l])
    }
    if(any(diffs > 1)){
        message(paste(granularity,'missing from time range, including:'))
        # get the right lubridate function for adding
        addfunc = switch(granularity,
            secs=seconds, mins=minutes, hours=hours, days=days, weeks=weeks)
        return(ordered_dates[which(diffs>1)] + addfunc(1))
    }else{
        return(TRUE)
    }
}
