\name{sanitize_text}
\alias{sanitize_text}
\title{sanitize_text}
\usage{
sanitize_text(input_text)
}
\arguments{
  \item{input_text}{The input text}
}
\description{
Removes UTF8 characters from text columns
}
\examples{
\dontrun{
sanitize_text("This is some bad text \\U3e32393cs that contains utf-8 characters")
}
}

