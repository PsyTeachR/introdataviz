suppressPackageStartupMessages({
  library(webexercises)
})

knitr::knit_hooks$set(webex.hide = function(before, options, envir) {
  if (before) {
    if (is.character(options$webex.hide)) {
      hide(options$webex.hide)
    } else {
      hide()
    }
  } else {
    unhide()
  }
})
