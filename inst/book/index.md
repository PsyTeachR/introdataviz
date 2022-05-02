--- 
title: "Data visualisation using R, for researchers who don’t use R"
author: "Emily Nordmann, Phil McAleer, Wilhelmiina Toivo, Helena Paterson, Lisa DeBruine"
date: "2022-05-02"
site: bookdown::bookdown_site
documentclass: book
classoption: oneside # for PDFs
geometry: margin=1in # for PDFs
bibliography: [book.bib, packages.bib]
csl: include/apa.csl
link-citations: yes
description: "In this tutorial, we provide a practical introduction to data visualisation using R, specifically aimed at researchers who have little to no prior experience of using R."
url: https://psyteachr.github.io/introdataviz
github-repo: psyteachr/introdataviz 
cover-image: images/logos/logo.png
apple-touch-icon: images/logos/apple-touch-icon.png 
apple-touch-icon-size: 180
favicon: images/logos/favicon.ico 
---




# Overview {-}

In addition to benefiting reproducibility and transparency, one of the advantages of using R is that researchers have a much larger range of fully customisable data visualisations options than are typically available in point-and-click software, due to the open-source nature of R. These visualisation options not only look attractive, but can increase transparency about the distribution of the underlying data rather than relying on commonly used visualisations of aggregations such as bar charts of means. 

In this tutorial, we provide a practical introduction to data visualisation using R, specifically aimed at researchers who have little to no prior experience of using R. First we detail the rationale for using R for data visualisation and introduce the "grammar of graphics" that underlies data visualisation using the ggplot2 package. The tutorial then walks the reader through how to replicate plots that are commonly available in point-and-click software such as histograms and boxplots, as well as showing how the code for these "basic" plots can be easily extended to less commonly available options such as violin-boxplots. 

The dataset and code used in this tutorial is available at [https://osf.io/bj83f/](https://osf.io/bj83f/) whilst an interactive version of this tutorial is available at [https://psyteachr.github.io/introdataviz/](https://psyteachr.github.io/introdataviz/) and includes solutions to the activities and an appendix with additional resources and advanced plotting options. 

## Citing

Please cite both the preprint and interactive online tutorial as: 

Nordmann, E., McAleer, P., Toivo, W., Paterson, H. & DeBruine, L. (2022). Data visualisation using R, for researchers who don't use R. Advances in Methods and Practices in Psychological Science. <https://doi.org/10.1177/25152459221074654>
