#' Get list of all autobahns in Germany
#'
#' @return A character vector.
#' @export
#'
#' @examples
#' autobahnen()
#'
#' @details
#' The function returns a vector of all autbahns in Germany. Under the hood it
#' calls [https://verkehr.autobahn.de/o/autobahn/](https://verkehr.autobahn.de/o/autobahn/).
#' For more information on the endpoint see:
#' [https://autobahn.api.bund.dev/](https://autobahn.api.bund.dev/).
#'
#' More information on Germany's autobahns can be found here:
#' [en.wikipedia.org/wiki/List_of_autobahns_in_Germany](https://en.wikipedia.org/wiki/List_of_autobahns_in_Germany)

autobahnen <- function() {
  httr2::request('https://verkehr.autobahn.de/o/autobahn/') |>
    httr2::req_user_agent("https://github.com/flrd/autobahn") |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE) |>
    extract("roads") |>
    # the API returns a malformated and duplicated value "A60 "
    # which we'll remove
    trimws() |>
    unique()
}

#' Get list of construction sites for a given autobahn
#'
#' @param roadId A character vector. Identifier of a autobahn.
#'
#' @return A list.
#' @export
#'
#' @examples
#' A1 <- autobahn_roadworks("A1")

autobahn_roadworks <- function(roadId = NULL) {

  json <- autobahn("roadwork", roadId = roadId)
  json[] <- lapply(json, geometryCoordinates)
  json[] <- lapply(json, description)
  json[] <- lapply(json, impactSymbols)
  json[] <- lapply(json, coordinate)
  json
}

#' Get list of parking lorries for a given autobahn
#'
#' @param roadId A character vector. Identifier of a autobahn.
#'
#' @return A list.
#' @export
#'
#' @examples
#' A1 <- autobahn_parking_lorry("A1")

autobahn_parking_lorry <- function(roadId = NULL) {

  json <- autobahn("parking_lorry", roadId = roadId)
  json[] <- lapply(json, parkingSpaces)
  json[] <- lapply(json, lorryParkingFeatureIcons)
  json[] <- lapply(json, coordinate)
  json
}

#' Get list of warnings for a given autobahn
#'
#' @param roadId A character vector. Identifier of a autobahn.
#'
#' @return A list.
#' @export
#'
#' @examples
#' A1 <- autobahn_warning("A1")

autobahn_warning <- function(roadId = NULL) {

  json <- autobahn("warning", roadId = roadId)
  json[] <- lapply(json, geometryCoordinates)
  json[] <- lapply(json, description)
  json[] <- lapply(json, lorryParkingFeatureIcons)
  json[] <- lapply(json, coordinate)
  json
}

#' Get list of closures for a given autobahn
#'
#' @param roadId A character vector. Identifier of a autobahn.
#'
#' @return A list.
#' @export
#'
#' @examples
#' A1 <- autobahn_closure("A1")

autobahn_closure <- function(roadId = NULL) {

  json <- autobahn("closure", roadId = roadId)
  json[] <- lapply(json, geometryCoordinates)
  json[] <- lapply(json, description)
  json[] <- lapply(json, lorryParkingFeatureIcons)
  json[] <- lapply(json, coordinate)
  json[] <- lapply(json, impactSymbols)
  json
}
