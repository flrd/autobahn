% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/autobahn.R
\name{autobahn_roadworks}
\alias{autobahn_roadworks}
\title{Get list of construction sites for a given autobahn}
\usage{
autobahn_roadworks(roadId = NULL, return = c("as-is", "simplified"))
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
Get list of construction sites for a given autobahn
}
\examples{
A1 <- autobahn_roadworks("A1")
A1 <- autobahn_roadworks("A1", return = "simplified")
}
