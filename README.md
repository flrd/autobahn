
<!-- README.md is generated from README.Rmd. Please edit that file -->

# autobahn <img src="man/figures/logo.png" align="right" height="138" alt="" />

<!-- badges: start -->
<!-- badges: end -->

The `autobahn` package provides an R interface to the [Autobahn App
API](https://autobahn.api.bund.dev/).

## Installation

You can install the development version of `autobahn` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("flrd/autobahn")
```

## What will you get

`autobahn` provides bindings to fetch data from the Autobahn App API,
see the [API documentation on their Swagger
UI](https://autobahn.api.bund.dev/) for more information.

The nomenclature of the functions follows the names of the resource
identifiers (URI) of the endpoints:

- `autobahn_roadworks()`
- `autobahn_parking_lorry()`
- `autobahn_warning()`
- `autobahn_closure()`
- `autobahn_electric_charging_station()`

The one exception to this rule is the function `autobahnen()` which
calls <https://verkehr.autobahn.de/o/autobahn/> and returns all
autobahns in Germany, see Examples section below.

### Examples

Get a list of all Autobahnen in Germany:

``` r
library(autobahn)
autobahnen() |> head()
#> [1] "A1" "A2" "A3" "A4" "A5" "A6"
```

Get a list of all electric charging stations on autobahn “A9”:

``` r
A9 <- autobahn_electric_charging_station(roadId = "A9")
A9[[1]]
#> $identifier
#> [1] "RUxFQ1RSSUNfQ0hBUkdJTkdfU1RBVElPTl9fNDkwNQ=="
#> 
#> $icon
#> [1] "charging_plug_strong"
#> 
#> $isBlocked
#> [1] "false"
#> 
#> $future
#> [1] FALSE
#> 
#> $extent
#> [1] "11.509981,49.748459,11.509981,49.748459"
#> 
#> $point
#> [1] "11.509981,49.748459"
#> 
#> $display_type
#> [1] "STRONG_ELECTRIC_CHARGING_STATION"
#> 
#> $subtitle
#> [1] "Schnellladeeinrichtung"
#> 
#> $title
#> [1] "A9 | Nürnberg | Raststätte Fränkische Schweiz-Pegnitz West"
#> 
#> $coordinate
#> $coordinate$lat
#> [1] "49.748459"
#> 
#> $coordinate$long
#> [1] "11.509981"
#> 
#> 
#> $description
#> $description[[1]]
#> [1] "A9 | Nürnberg | Raststätte Fränkische Schweiz-Pegnitz West"
#> 
#> $description[[2]]
#> [1] "91257 Pegnitz"
#> 
#> $description[[3]]
#> [1] ""
#> 
#> $description[[4]]
#> [1] "Ladepunkt 1:"
#> 
#> $description[[5]]
#> [1] "AC Kupplung Typ 2"
#> 
#> $description[[6]]
#> [1] "43 kW"
#> 
#> $description[[7]]
#> [1] ""
#> 
#> $description[[8]]
#> [1] "Ladepunkt 2:"
#> 
#> $description[[9]]
#> [1] "DC Kupplung Combo, DC CHAdeMO"
#> 
#> $description[[10]]
#> [1] "50 kW"
#> 
#> 
#> $routeRecommendation
#> list()
#> 
#> $footer
#> list()
#> 
#> $lorryParkingFeatureIcons
#> list()
```

Each of the `autobahn_*` functions has two arguments:

1.  `roadId`
2.  `return`

The first is the identifier of a autobahn, the second argument can take
one of two values: `"as-is"`, and `"simplified"`. Default is `"as-is"`
and the data is returned – well – as is. If you choose the option
`"simplified"` then the data is returned in a way that shall make it
easier for you to work with it.

``` r
A9_simple <- autobahn_electric_charging_station(roadId = "A9", return = "simplified")
A9_simple[[1]]
#> $identifier
#> [1] "RUxFQ1RSSUNfQ0hBUkdJTkdfU1RBVElPTl9fNDkwNQ=="
#> 
#> $icon
#> [1] "charging_plug_strong"
#> 
#> $isBlocked
#> [1] "false"
#> 
#> $future
#> [1] FALSE
#> 
#> $extent
#> [1] "11.509981,49.748459,11.509981,49.748459"
#> 
#> $point
#> [1] "11.509981,49.748459"
#> 
#> $display_type
#> [1] "STRONG_ELECTRIC_CHARGING_STATION"
#> 
#> $subtitle
#> [1] "Schnellladeeinrichtung"
#> 
#> $title
#> [1] "A9 | Nürnberg | Raststätte Fränkische Schweiz-Pegnitz West"
#> 
#> $coordinate
#> [1] 49.74846 11.50998
#> 
#> $description
#> [1] "A9 | Nürnberg | Raststätte Fränkische Schweiz-Pegnitz West\n91257 Pegnitz"
#> 
#> $routeRecommendation
#> list()
#> 
#> $footer
#> list()
#> 
#> $lorryParkingFeatureIcons
#> data frame with 0 columns and 0 rows
#> 
#> $charging_stations
#>                      Steckertyp Leistung Einheit
#> 1             AC Kupplung Typ 2       43      kW
#> 2 DC Kupplung Combo, DC CHAdeMO       50      kW
```

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/flrd/autobahn/blob/main/CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.
