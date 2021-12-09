# render bookdown ----
xfun::in_dir("book", bookdown::render_book("index.Rmd"))
browseURL("docs/index.html")

# copies book for local package copy ----
R.utils::copyDirectory(
  from = "docs",
  to = "inst/book", 
  overwrite = TRUE, 
  recursive = TRUE)





# create PDF ----

# copy files from book
file.copy("book/book.bib", "paper/", overwrite = TRUE)
file.copy("book/ldt_data.csv", "paper/", overwrite = TRUE)

# copy and process chapters
files <- sprintf("book/0%d-ch%d.Rmd", 1:6, 1:6)
for (bookfile in files) {
  paperfile <- gsub("book/", "paper/", bookfile)
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
ch6 <- readLines("paper/06-ch6.Rmd")
ch6 <- gsub("r (splitviolin|raincloud|ridgeplot|alluvial|map),", "r \\1, echo = FALSE,", ch6)
write(ch6, "paper/06-ch6.Rmd")

# render PDF
rmarkdown::render("paper/introdataviz.Rmd")

