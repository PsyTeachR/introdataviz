01.AMPSS_LMEM.pdf : 01.AMPSS_LMEM.Rmd r-references.bib
	Rscript -e 'rmarkdown::render("01.AMPSS_LMEM.Rmd", papaja::apa6_pdf())'

manuscript_code.R : 01.AMPSS_LMEM.Rmd
	Rscript -e 'knitr::purl("01.AMPSS_LMEM.Rmd", "manuscript_code.R")'
