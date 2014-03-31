#' Determine if numbers meet criteria
#' @param x a vector that should represent count data
#' @export
is.count = function(
  x
){
  tol = .Machine$double.eps^0.5
  (abs(x - round(x)) < tol) & x > 0
}


is.proportion = function(
  x
){
  x <= 1 & x >= 0
}

is.percent = function(
  x
){
  x <= 100 & x >= 0
}
