make_dataset <- function(dataname, title, desc, itemdesc = list(), filetype = "csv", source = "", write = TRUE) {
  
  # read data and save to data directory
  datafile <- paste0("data-raw/", dataname, ".", filetype)
  if (filetype == "csv") {
    data <- readr::read_csv(datafile, col_types = readr::cols())
  } else if (filetype == "xls") {
    data <- readxl::read_xls(datafile)
  }
  
  # create Roxygen description
  items <- paste0("#'    \\item{", names(itemdesc), "}{", itemdesc, "}")
  
  s <- sprintf("# %s ----\n#' %s\n#'\n#' %s\n#'\n#' @format A data frame with %d rows and %d variables:\n#' \\describe{\n%s\n#' }\n#' @source \\url{%s}\n\"%s\"\n\n",
               dataname, title, 
               gsub("\n+", "\n#'\n#' ", desc), 
               nrow(data), ncol(data),
               paste(items, collapse = "\n"),
               source, dataname
  )
  if (!isFALSE(write)) write(s, paste0("R/", dataname, ".R"))
  invisible(s)
}

## code to prepare `ldt_data` ----

suppressPackageStartupMessages(library(faux))
faux_options(plot = FALSE)
set.seed(8675309)

wide <- sim_design(
  within= list(
    dv = c("rt", "acc"),
    type = c("word", "nonword")),
  between = list(language = c("1", "2")),
  n = list("1" = 55, "2" = 45),
  mu = data.frame(
    row.names = c("1", "2"),
    rt_word = c(360, 350),
    rt_nonword = c(450, 600),
    acc_word = c(0, 0), # will convert to binomial later
    acc_nonword = c(0, 0) # will convert to binomial later
  ),
  sd = c(50, 50, 1, 1, 50,  50, 1, 1),
  # RTi, a_c, a_i
  r = c( .5,  .6,  .3, # RTc
         .4,  .5, # RTi
         .6) # a_c
) %>%
  mutate(
    acc_word = norm2binom(acc_word, size = 100, prob = .95),
    acc_nonword = norm2binom(acc_nonword, size = 100, prob = .85),
    # generate age with correlations to rt and none to acc
    age = rnorm_pre(data.frame(rt_word, rt_nonword, acc_word, acc_nonword), 
                    mu = 25, sd = 10, r = c(0.3, 0.3, 0, 0)),
    # truncate and round ages
    age = norm2trunc(age, 17.51, 60.49) %>% round()
  ) %>%
  select(id, age, everything())

# long <- pivot_longer(wide, 
#                      cols = rt_word:acc_nonword, 
#                      names_to = c("DV_type", "condition"), 
#                      names_sep = "_", 
#                      values_to = "DV")
# 
# dat <- pivot_wider(long, names_from = DV_type, values_from = DV)
write_csv(wide, "data-raw/ldt_data.csv")

ldt_data <- read_csv("data-raw/ldt_data.csv")
usethis::use_data(ldt_data, overwrite = TRUE)

itemdesc <- list(
  id = "Participant ID",
  age = "Age of participant in years",
  language = "Languages (1 = monolingual, 2 = bilingual)",
  rt_word = "Mean reaction time (ms) for words",
  rt_nonword = "Mean reaction time (ms) for non-words",
  acc_word = "Accuracy for words",
  acc_nonword = "Accuracy for non-words"
)

make_dataset("ldt_data", "Stroop Task Example Data", "Simulated stroop task data for monolingual and bilingual participants. DVs are mean reaction time (rt) and accuracy (acc) for words and non-words.", itemdesc = itemdesc) 

# ldt_long ----
library(dplyr)

ldt_long <- introdataviz::ldt_data %>%
  dplyr::mutate(language = factor(
    x = language,
    levels = c(1, 2),
    labels = c("monolingual", "bilingual") 
  )) %>%
  tidyr::pivot_longer(
    cols = rt_word:acc_nonword, 
    names_to = c("dv_type", "condition"), 
    names_sep = "_", 
    values_to = "dv") %>%
  tidyr::pivot_wider(
    names_from = "dv_type", 
    values_from = "dv")

readr::write_csv(ldt_long, "data-raw/ldt_long.csv")

usethis::use_data(ldt_long, overwrite = TRUE)

itemdesc <- list(
  id = "Participant ID",
  age = "Age of participant in years",
  language = "Languages (monolingual, bilingual)",
  condition = "Trial condition (word, nonword)",
  rt = "Mean reaction time (ms)",
  acc = "Accuracy"
)

make_dataset("ldt_long", "Stroop Task Example Data - long format", "Simulated stroop task data for monolingual and bilingual participants. DVs are mean reaction time (rt) and accuracy (acc) for words and non-words.", itemdesc = itemdesc) 
