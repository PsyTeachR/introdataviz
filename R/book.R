#' Open the introdataviz book
#'
#' @return NULL
#' @export
#'
book <- function() {
  file <- system.file("book", "index.html", package = "introdataviz")
  utils::browseURL(file)
}


#' Get workbook exercise and data
#'
#' @return Saves files to the working directory
#' @export
#'
workbook <- function() {
  wb <- system.file("OSF/workbook.Rmd", package = "introdataviz")
  dat <- system.file("OSF/ldt_data.csv", package = "introdataviz")
  
  file.copy(wb, "workbook.Rmd")
  file.copy(dat, "ldt_data.csv")
  utils::browseURL("workbook.Rmd")
}
