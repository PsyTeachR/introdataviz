# render bookdown ----

# change wd
setwd(rstudioapi::getActiveProject())
setwd("book")

# render a chapter or the whole book
#browseURL(bookdown::preview_chapter("06-ch6.Rmd"))

# preview = TRUE to run faster, but misses some linking
browseURL(bookdown::render_book("index.Rmd", preview = FALSE))


# copies book for local package copy ----
R.utils::copyDirectory(
  from = "../docs",
  to = "../inst/book", 
  overwrite = TRUE, 
  recursive = TRUE)


# create PDF ----

# copy files from book
file.copy("book.bib", "../paper/", overwrite = TRUE)
file.copy("ldt_data.csv", "../paper/", overwrite = TRUE)

# copy and process chapters
files <- sprintf("0%d-ch%d.Rmd", 1:6, 1:6)
for (bookfile in files) {
  paperfile <- paste0("../paper/", bookfile)
  file.copy(bookfile, paperfile, overwrite = TRUE)
  
  ch <- readLines(paperfile)
  #ch <- gsub("^#", "##", ch) # increments header
  
  # remove solutions
  hides <- grep("^`r hide", ch)
  unhides <- grep("^`r unhide", ch)
  to_omit <- mapply(function(a, b) a:b, hides, unhides)
  to_omit <- unlist(to_omit)
  if (length(to_omit) > 0) ch <- ch[-to_omit]
  
  write(ch, paperfile)
}

# omit code from ch 6
ch6 <- readLines("../paper/06-ch6.Rmd")
ch6 <- gsub("r (splitviolin|raincloud|ridgeplot|alluvial),", "r \\1, echo = FALSE,", ch6)
write(ch6, "../paper/06-ch6.Rmd")

# render PDF
rmarkdown::render("../paper/introdataviz.Rmd")

