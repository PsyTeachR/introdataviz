# change wd
setwd(rstudioapi::getActiveProject())
setwd("book")

# render a chapter or the whole book
#browseURL(bookdown::preview_chapter("01-ch1.Rmd"))
browseURL(bookdown::render_book("index.Rmd", preview = TRUE))

# copies dir
R.utils::copyDirectory(
  from = "../docs",
  to = "../inst/book", 
  overwrite = TRUE, 
  recursive = TRUE)
