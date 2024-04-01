#' Get list of all Autobahnen in Germany.
#'
#' @return A character vector.
#' @export
#'
#' @examples
#' autobahnen()
#'
#' @details
#' The function returns a list of all autbahns in Germany. Under the hood it
#' calls https://verkehr.autobahn.de/o/autobahn/. For more information on the
#' endpoint see: https://autobahn.api.bund.dev/.
#'
#' More information on Germany's autobahns can be found here:
#' https://en.wikipedia.org/wiki/List_of_autobahns_in_Germany

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

# helpers

extract <- `[[`
