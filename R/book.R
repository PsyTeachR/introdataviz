' Open the introdataviz book
#'
#' @return NULL
#' @export
#'
book <- function() {
  file <- system.file("book", "index.html", package = "introdataviz")
  utils::browseURL(file)
}