# psyTeachR styles and functions
# do not edit!!!!!

suppressPackageStartupMessages({
  library(tidyverse)
  library(glossary)
})

# default knitr options
knitr::opts_chunk$set(
  echo       = TRUE,
  results    = "hold",
  out.width  = '100%',
  fig.width  = 8,
  fig.height = 5,
  fig.align  = 'center'
)

## set global theme options for figures
theme_set(theme_bw())

## set class for a chunk using class="className"
knitr::knit_hooks$set(class = function(before, options, envir) {
  if (before) {
    sprintf("<div class = '%s'>", options$class)
  } else {
    "</div>"
  }
})

## verbatim code chunks
knitr::knit_hooks$set(verbatim = function(before, options, envir) {
  if (before) {
    sprintf("<div class='verbatim'><pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;{%s}</code></pre>", options$verbatim)
  } else {
    "<pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;</code></pre></div>"
  }
})

## verbatim inline R in backticks
backtick <- function(code) {
  warning("The backtick() function is deprecated. Use two backticks and a space to surround text with verbatim backticks, e.g. `` `in_backticks` ``")
  # removes inline math coding when you use >1 $ in a line
  code <- gsub("\\$", "\\\\$", code)
  paste0("<code>&#096;", code, "&#096;</code>")
}

## palette with psyTeachR logo colour
psyteachr_colours <- function(vals = 1:6) {
  ptrc <- c(
    "pink" = "#983E82",
    "orange" = "#E2A458",
    "yellow" = "#F5DC70",
    "green" = "#59935B",
    "blue" = "#467AAC",
    "purple" = "#61589C"
  )
  
  unname(ptrc[vals])
}
psyteachr_colors <- psyteachr_colours

# inline code highlighting and styles

hl <- function(code) {
  txt <- rlang::enexpr(code) %>% rlang::as_label()
  
  downlit::highlight(txt, classes = downlit::classes_pandoc()) %>%
    gsub("a href", "a target='_blank' href", .) %>%
    paste0("<code>", . , "</code>")
}

path <- function(txt) {
  sprintf("<code class='path'>%s</code>", txt)
}

pkg <- function(txt, url = NULL) {
  if (is.null(url)) {
    sprintf("<code class='package'>%s</code>", txt)
  } else {
    sprintf("<code class='package'><a href='%s' target='_blank'>%s</a></code>", url, txt)
  }
}
