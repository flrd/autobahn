
<!-- README.md is generated from README.Rmd. Please edit that file -->

# \[WIP\] autobahn <img src="man/figures/logo.png" align="right" height="138" alt="" />

<!-- badges: start -->
<!-- badges: end -->

The `autobahn` package provides an R interface to the [Autobahn
API](https://autobahn.api.bund.dev/).

## Installation

You can install the development version of `autobahn` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("flrd/autobahn")
```

## Example

Get a list of all Autobahnen in Germany:

``` r
library(autobahn)
autobahnen() |> head()
#> [1] "A1" "A2" "A3" "A4" "A5" "A6"
```
