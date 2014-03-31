#' Browse dataset in your default browser.
#' 
#' @import whisker
#' @param input Input
#' @param output Path and file name for output file. If NULL, a temporary file is used.
#' @param browse Browse file in your default browse immediately after file creation.
#'    If FALSE, the file is written, but not opened.
#' @export
#' @examples \dontrun{
#' browse_dat(input=mtcars)
#' browse_dat(iris)
#' }

browse_dat <- function(input=NULL, output=NULL, browse=TRUE)
{
  if(is.null(input))
    stop("Please supply some input")
  
#   outlist <- apply(input, 1, as.list)
  
  res <- print(xtable(input), type = "html",include.colnames = TRUE)
  
  rendered <- sprintf('<!DOCTYPE html>
      <head>
        <meta charset="utf-8">
      	<title>testdat</title>
      	<meta name="viewport" content="width=device-width, initial-scale=1.0">
      	<meta name="description" content="Browse datasets">
      	<meta name="author" content="testdat">

      	<!-- Le styles -->
      	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
      </head>

      <body>

      <div class="container">

      <center><h2>testdat <i class="fa fa-lightbulb-o"></i></h2></center>
      
      %s
      
      </div>

      <script src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
      <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>

      </body>
      </html>', res)
  
  rendered <- sub('<TABLE border=1>', '<table class="table table-striped table-hover" align="left">', rendered)
        
  if(is.null(output))
    output <- tempfile(fileext=".html")
  write(rendered, file = output)
  if(browse) browseURL(output)
}