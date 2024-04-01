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
    # "webcam",
    "parking_lorry",
    "warning",
    "closure",
    "electric_charging_station"
  )

autobahn <- function(resource, roadId = NULL) {

  resource <- match.arg(
    resource,
    choices = resources,
    several.ok = FALSE
  )

  httr2::request('https://verkehr.autobahn.de/o/autobahn/') |>
    httr2::req_url_path_append(roadId, "services", resource) |>
    httr2::req_user_agent("https://github.com/flrd/autobahn") |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

# helpers creating a function for each API endpoint -----------------------

# ensure roadId is provided, don't mind spelling
road_id <- function(roadId = NULL) {
  choices <- autobahnen()
  if(!is.null(roadId)) {
    roadId <- toupper(roadId)
  }
  if(is.null(roadId) || !(roadId %in% choices)) {
    stop("Invalid 'roadId', call `autobahnen()` for possible values.",
         call. = FALSE)
  }
  match.arg(arg = roadId,
            choices = choices,
            several.ok = FALSE)
}

# function factory to call various endpoints
endpoint <- function(endpoint) {
  function(roadId = NULL) {
    roadId <- road_id(roadId = roadId)
    autobahn(endpoint, roadId = roadId)
  }
}
