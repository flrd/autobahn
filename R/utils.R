# https://autobahn.api.bund.dev/
# libraries ---------------------------------------------------------------

library(httr2)

# API patterns ------------------------------------------------------------

# Baustellen:         /{roadId}/services/roadworks
# Webcams:            /{roadId}/services/webcam
# Rastplätze:         /{roadId}/services/parking_lorry
# Verkehrsmeldungen:  /{roadId}/services/warning
# Sperrungen:         /{roadId}/services/closure
# Ladestationen:      /{roadId}/services/electric_charging_station

resources <-
  c(
    "roadworks",
    # "webcam", # not supported as of April 2024
    "parking_lorry",
    "warning",
    "closure",
    "electric_charging_station"
  )

# helpers creating a function for each resource ---------------------------

extract <- `[[`

# ensure a value for roadId is provided, don't mind its spelling
road_id <- function(roadId = NULL) {
  choices <- autobahnen()
  if(!is.null(roadId)) {
    roadId <- toupper(roadId)
  }
  if(is.null(roadId) || !(roadId %in% choices)) {
    stop("Missing or invalid 'roadId', call `autobahnen()` for possible values.",
         call. = FALSE)
  }
  match.arg(arg = roadId,
            choices = choices,
            several.ok = FALSE)
}


# workhorse ---------------------------------------------------------------

autobahn <- function(resource, roadId = NULL) {

  roadId <- road_id(roadId)

  resource <- match.arg(
    resource,
    choices = resources,
    several.ok = FALSE
  )

  httr2::request('https://verkehr.autobahn.de/o/autobahn/') |>
    httr2::req_url_path_append(roadId, "services", resource) |>
    httr2::req_user_agent("https://github.com/flrd/autobahn") |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    extract(resource)
}


# function factory to create autobahn_{resouce} functions -----------------

getter <- function(endpoint) {
  function(roadId = NULL) {
    roadId <- road_id(roadId = roadId)
    autobahn(endpoint, roadId = roadId)
  }
}


# helpers to tidy output --------------------------------------------------

geometryCoordinates <- function(x) {
  idx <- c("geometry", "coordinates")
  x[[idx]] <- do.call(rbind, x[[idx]]) |>
    as.data.frame() |>
    setNames(c("long", "lat"))
  x
}

description <- function(x) {
  tmp <- x[["description"]]
  x[["description"]] <- paste0(tmp[nzchar(tmp)], collapse = "\n")
  x
}

impactSymbols <- function(x) {
  idx <- c("impact", "symbols")
  x[[idx]] <- unlist(x[[idx]], use.names = FALSE)
  x
}

coordinate <- function(x) {
  x[["coordinate"]] <- unlist(x[["coordinate"]], use.names = TRUE) |>
    as.double()
  x
}

parkingSpaces <- function(x) {
  tmp <- x[["description"]]
  x[["description"]] <- unlist(tmp) |>
    strsplit(x = _, split = " Stellpl\u00E4tze: ", useBytes = TRUE) |>
    do.call(rbind.data.frame, args = _) |>
    setNames(nm = c("Fahrzeugtyp", "Stellpl\u00E4tze"))
  x
}

lorryParkingFeatureIcons <- function(x) {
  tmp <- "lorryParkingFeatureIcons"
  x[[tmp]] <- do.call(rbind.data.frame, x[[tmp]])
  x
}
