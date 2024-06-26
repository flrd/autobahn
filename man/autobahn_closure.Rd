% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/autobahn.R
\name{autobahn_closure}
\alias{autobahn_closure}
\title{Get list of closures for a given autobahn}
\usage{
autobahn_closure(roadId = NULL, return = c("as-is", "simplified"))
}
\arguments{
\item{roadId}{A character string. Identifier of a autobahn.}

\item{return}{Should function return result as is, or simplify the
response? Defaults to \code{as-is}.}
}
\value{
A list.
}
\description{
Get list of closures for a given autobahn
}
\examples{
A4 <- autobahn_closure("A4")
A4 <- autobahn_closure("A4", return = "simplified")
}
