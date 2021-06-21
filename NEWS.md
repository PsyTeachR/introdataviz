# introdataviz 0.0.0.9002

* wrote code for the ggridge plot
* Updated advanced plots
* papaja format
* changed labeller to factor for facet labels

# introdataviz 0.0.0.9001

## Phil's comments

* General:
  * &#9989; All the chapters are labelled Chapter X Chapter X [fixed - check if chapter titles are OK]
  * &#9989; We don' t cite R or RStudio at all as far as I can see [added to text and bib]
  * &#9989; Something weird going on with the reference and citation structure (no comma) - basically not quite APA [added apa.csl]
* &#9989; 1.1: "The level of customisation and the professional outputs available using R has for instance lead news outlets such as the BBC (Visual and Journalism 2019) and the New York Times (Bertini and Stefaner 2015) adopting R as their preferred data visualisation tool." Is this sentence maybe missing a "to" as in "to adopting"?
* &#10060; 1.3: Might benefit from showing the data using head() of table to help people visualise the data - say if they reading along and not working through
* &#9989; 1 = monolingual/2 = bilingual might be easier as 1 = monolingual, 2 = bilingual
* &#9989; rt_word and rt_nonword have a \ at end of name [fixed]
* 1.4
  * &#9989; can link have target=_blank on it to keep the workbook open
  * is there still that issue with Macs and csv files? Maybe store data as zip?
  * &#9989; "The R Markdown workbook available in the online materialscontains all the code" - just needs a space after materials
* &#9989; 1.5.3: "A great benefit to using R rather than SPSS is that categorical data can be entered as text." Is this true about SPSS? I wasn't sure as I thought you can do that. But also, sentence would still work without the "rather than SPSS" bit and maybe not get the hackles of the SPSS people up.
* &#9989; 2.5: "This code produces summary data in the form of a column named mean_age that contains the result of calculating the mean of the variable age." The fullstop after age is contained within the backticks here
* &#10060; 2.6: Wondered as it was the first plot if it might help just to show the patchwork layers version as well to accompany the text that talks about it.
* &#9989; 3.2: "This final long-form data should looks like Table 3.4." - i think it should reference Table 3.2 instead? [I also clarified the table caption for step 2]
* &#9989; 3.8: The activities and footnotes are a bit messed up as they are like Inception as 5 is in 4 which is in 3 [I added the missing unhides]
* &#10060; 4.1.1: theme_classic() is in the code but never mentioned prior or in the text. Might make sense as themes are mentioned earlier but we don't really say "and other themese are...." so it sort of just jumped out as coming from nowhere [2.9.4 mentions this]
* &#9989; 4.4: might help to point out the new geom is geom = errorbar We mention point and bar but not errorbar and just thought it might make it clearer. [updated: "In the below code we first draw a violin plot, then layer on a boxplot, a point for the mean (note `geom = "point"` instead of `"bar"`) and standard error bars (`geom = "errorbar"`)."]
* &#9989; 5.3: Would scale_x_discrete work here? I actually don't get what scale_color_discrete works and it sort of doesn't make sense as there is no color layer obvious. [It's not doing anything. I've just removed it here because the labeller function is explained later.]
* &#9989; There is also a missing reference on "as an alternative to the grouped violin-boxplot (see Figure X" [viobox3]
* &#9989; 5.4: Maybe better titled as "storing plots"
* &#9989; 5.5: in turn could be titled "saving and exporting plots" [Saving plots as images]
* &#9989; 5.8: FIgures 5.8 and 5.11 need captions [Set fig.cap=NULL if you want to skip a caption]
* &#9989; Chapter 6: the number of sections changes to .0.x
* &#9989; 6.0.3: Could maybe do caption using this approach if it is a figure: https://psyteachr.github.io/book-template/psyteachr-style-guide.html#images
* &#9989; Conclusion: just needs a header [That makes it a separate chapter...]
  
## Lisa changes

* updates to raincloud plots
* _render.R gives code to render bookdown and move to correct package placement
* updated README
* added alluvial plot with simulated data
* Added data link to Chapter 2 for people who skip around.
* Changed "non-meaningful colours" to "redundant aesthetics", as the colours still have meaning here. I also edited some of the text accordingly.

# introdataviz 0.0.0.9000

* Put all materials in a package format
