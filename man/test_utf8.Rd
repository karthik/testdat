\name{test_utf8}
\alias{test_utf8}
\title{Test for UTF-8 characters}
\usage{
test_utf8(dat, verbose = F)
}
\arguments{
  \item{dat}{input dataset. Currently only supports
  \code{data.frame} but will soon support
  \code{data.table}}
}
\description{
This test will check every column in a data.frame for
possible unicode characters.
}
\examples{
\dontrun{
data(iris)
test_utf8(iris)
temp <- structure(list(x = 'The\\U3e32393cs quick brown fox jumps over the \\U3e32393cs the lazy dog', y = 'Lorem\\U3e32393cs ipsum \\U3e32393cs dolor', dat = 43.5), .Names = c('x', 'y', 'dat'), row.names = c(NA, -1L), class = 'data.frame')
test_utf8(temp)
}
}

