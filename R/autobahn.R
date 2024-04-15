#' Get list of all autobahns in Germany
#'
#' @return A character vector.
#' @export
#'
#' @examples
#' autobahnen()
#'
#' @details
#' The function calls
#' [https://verkehr.autobahn.de/o/autobahn/](https://verkehr.autobahn.de/o/autobahn/)
#' and returns a vector of all autobahns in Germany, see:
#' [https://autobahn.api.bund.dev/](https://autobahn.api.bund.dev/).
#'
#' More information on Germany's autobahns can be found on
#' [wikipedia.org](https://en.wikipedia.org/wiki/List_of_autobahns_in_Germany)

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
#' @param roadId A character string. Identifier of a autobahn.
#' @param return Should function return result as is, or simplify the
#' response? Defaults to `as-is`.
#'
#' @return A list.
#' @export
#'
#' @examples
#' A1 <- autobahn_roadworks("A1")
#' A1 <- autobahn_roadworks("A1", return = "simplified")

autobahn_roadworks <- function(roadId = NULL, return = c("as-is", "simplified")) {

  return <- match.arg(return)
  json <- autobahn("roadworks", roadId = roadId)

  if(identical(return, "as-is")) {
    return(json)
  } else {
    json[] <- lapply(json, geometryCoordinates)
    json[] <- lapply(json, description)
    json[] <- lapply(json, impactSymbols)
    json[] <- lapply(json, coordinate)
    return(json)
  }
}

#' Get list of rest areas for a given autobahn
#'
#' @param roadId A character string. Identifier of a autobahn.
#' @param return Should function return result as is, or simplify the
#' response? Defaults to `as-is`.
#'
#' @return A list.
#' @export
#'
#' @examples
#' A2 <- autobahn_parking_lorry("A2")
#' A2 <- autobahn_parking_lorry("A2", return = "simplified")

autobahn_parking_lorry <- function(roadId = NULL, return = c("as-is", "simplified")) {

  return <- match.arg(return)
  json <- autobahn("parking_lorry", roadId = roadId)

  if(identical(return, "as-is")) {
    return(json)
  } else {
    json[] <- lapply(json, parkingSpaces)
    json[] <- lapply(json, lorryParkingFeatureIcons)
    json[] <- lapply(json, coordinate)
    return(json)
  }
}

#' Get list of warnings for a given autobahn
#'
#' @param roadId A character string. Identifier of a autobahn.
#' @param return Should function return result as is, or simplify the
#' response? Defaults to `as-is`.
#'
#' @return A list.
#' @export
#'
#' @examples
#' A3 <- autobahn_warning("A3")
#' A3 <- autobahn_warning("A3", return = "simplified")

autobahn_warning <- function(roadId = NULL, return = c("as-is", "simplified")) {

  return <- match.arg(return)
  json <- autobahn("warning", roadId = roadId)

  if(identical(return, "as-is")) {
    return(json)
  } else {
    json[] <- lapply(json, geometryCoordinates)
    json[] <- lapply(json, description)
    json[] <- lapply(json, lorryParkingFeatureIcons)
    json[] <- lapply(json, coordinate)
    return(json)
  }
}

#' Get list of closures for a given autobahn
#'
#' @param roadId A character string. Identifier of a autobahn.
#' @param return Should function return result as is, or simplify the
#' response? Defaults to `as-is`.
#'
#' @return A list.
#' @export
#'
#' @examples
#' A4 <- autobahn_closure("A4")
#' A4 <- autobahn_closure("A4", return = "simplified")

autobahn_closure <- function(roadId = NULL, return = c("as-is", "simplified")) {

  return <- match.arg(return)
  json <- autobahn("closure", roadId = roadId)

  if(identical(return, "as-is")) {
    return(json)
  } else {
    json[] <- lapply(json, geometryCoordinates)
    json[] <- lapply(json, description)
    json[] <- lapply(json, lorryParkingFeatureIcons)
    json[] <- lapply(json, coordinate)
    json[] <- lapply(json, impactSymbols)
    return(json)
  }
}

#' Get list of electric charging stations for a given autobahn
#'
#' @param roadId A character string. Identifier of a autobahn.
#' @param return Should function return result as is, or simplify the
#' response? Defaults to `as-is`.
#'
#' @return A list.
#' @export
#'
#' @examples
#' A5 <- autobahn_electric_charging_station("A5")
#' A5 <- autobahn_electric_charging_station("A5", return = "simplified")

autobahn_electric_charging_station <- function(roadId = NULL, return = c("as-is", "simplified")) {

  return <- match.arg(return)
  json <- autobahn("electric_charging_station", roadId = roadId)

  if(identical(return, "as-is")) {
    return(json)
  } else {
    json[] <- lapply(json, ladestationDescription)
    json[] <- lapply(json, lorryParkingFeatureIcons)
    json[] <- lapply(json, coordinate)
    return(json)
  }
}


