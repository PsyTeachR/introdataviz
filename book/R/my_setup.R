# book-specific code to include on every page

library(introdataviz)
library(patchwork)
library(knitr)

theme_set(theme_grey())

dat <- introdataviz::ldt_data %>%
  mutate(language = factor(
    x = language, # column to translate
    levels = c(1, 2), # values of the original data in preferred order
    labels = c("monolingual", "bilingual") # labels for display
  ))

long <- pivot_longer(dat, 
                     cols = rt_word:acc_nonword, 
                     names_to = c("dv_type", "condition"), 
                     names_sep = "_", 
                     values_to = "dv")

dat_long <- pivot_wider(long, 
                        names_from = "dv_type", 
                        values_from = "dv")
