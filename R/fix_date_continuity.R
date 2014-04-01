#' Add NA rows to datestream datasets
#' 
#' For a dataset that should contain at least one observation for each day
#' (or second, minute, hour, etc), add NA rows for the missing observations
#' 
#' @param dat data frame with a date column that should contain a continuous stream of dates
#' @param index index of column in \code{dat} containing dates
#' @param form a lubridate parsing function in the \code{ymd} family, specifying the format the dates in \code{dat} are expected to be in. Default \code{ymd}.
#' @param granularity what are the datestream units? Choose one of \code{'secs'}, \code{'mins'}, \code{'hours'}, \code{'days'}, \code{'weeks'}, \code{'years'}. Default \code{'days'}.
#' @import lubridate
#' @return a data frame, sorted by the dates in \code{dat[,index]}, with the missing observations added. Dates in \code{dat[,index]} will be formatted as \code{POSIXct}, due to conversion with \code{lubridate}.
#' @export

fix_date_continuity = function(dat, index, form=ymd, granularity='days'){
    granularity = match.arg(granularity, c('secs', 'mins', 'hours', 'days', 'weeks', 'years'))

    ordered_dates = sort(form(dat[,index]))
    l = length(ordered_dates)
    if(granularity != 'years'){
        diffs = difftime(ordered_dates[-1], ordered_dates[-l], units=granularity)
    }else{
        diffs = year(ordered_dates[-1]) - year(ordered_dates[-l])
    }

    addfunc = switch(granularity,
        secs=seconds, mins=minutes, hours=hours, days=days, weeks=weeks)

    add_after = which(diffs > 1)
    how_many = as.numeric(diffs[add_after])-1

    new_dates = mapply(function(x,y){
        seq(ordered_dates[x] + addfunc(1), by=granularity, length.out=y)
    }, add_after, how_many)

    # return data will be sorted by date and have dates in POSIX format
    return_dat = dat[order(form(dat[,index])),]
    return_dat[,1] = ordered_dates
    insert = matrix(NA, nrow=sum(how_many), ncol=ncol(dat))
    insert = as.data.frame(insert)
    insert[,index] = do.call(c, new_dates)
    names(insert) = names(dat)
    return_dat = rbind(return_dat, insert)
    return_dat = return_dat[order(return_dat[,index]),]
    rownames(return_dat) = NULL

    return_dat
}

