# script to process data from VCDS realtime

#### SETUP ####
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(tidyverse)
library(janitor)

#### USER DEFINED VARIABLES ###
infile = "LOG-01-IDE00021_&11.CSV"

#### READ IN DATA ####
# make header row
header_row <- 
  read_csv("LOG-01-IDE00021_&11.CSV",
           skip = 2,
           col_names = FALSE,
           n_max = 4) %>%
  aggregate(by = list(c(1,
                        1,
                        1,
                        1)), 
            FUN = paste, 
            collapse = "_") %>%
  select(-Group.1,
         -X1,
         -X26,
         -X27) %>%
  t() %>%
  unlist(use.names = FALSE)

# Read in the data from the text file
data <- 
  read_csv("LOG-01-IDE00021_&11.CSV",
           skip = 6) %>%
  select(-...1,
         -...26)

colnames(data) <- header_row

data_vcds <-
  data %>%
  clean_names()

rm(data,
   header_row)

#### PLOT DATA ####

data_vcds %>% 
  select(g003_loc_ide00021_engine_rpm_min,
         g180_loc_ide01775_misfires_per_1000_revolutions_of_cylinder_1_na,
         g181_loc_ide01776_misfires_per_1000_revolutions_of_cylinder_2_na,
         g182_loc_ide01777_misfires_per_1000_revolutions_of_cylinder_3_na,
         g183_loc_ide01778_misfires_per_1000_revolutions_of_cylinder_4_na) %>%
  pivot_longer(cols = starts_with("g18"),
               names_to = "cylinder",
               values_to = "misfires_per_1000_revs") %>%
  mutate(cylinder = str_remove(cylinder,
                               "^g18.*der_"),
         cylinder = str_remove(cylinder,
                               "_na")) %>%
  group_by(g003_loc_ide00021_engine_rpm_min,
           misfires_per_1000_revs,
           cylinder) %>%
  summarize(num_obs = n()) %>%
  filter(misfires_per_1000_revs > 0) %>%
  # transform(group = interaction(g003_loc_ide00021_engine_rpm_min,
  #                               misfires_per_1000_revs,
  #                               cylinder)) %>% 
  ggplot(aes(x=g003_loc_ide00021_engine_rpm_min,
             y=misfires_per_1000_revs,
             color = cylinder,
             size = num_obs)) +
  geom_jitter(alpha = 0.3,
              width = 100,
              height = .5) +
  # scale_size(range = c(1,6)) +
  facet_grid(cylinder ~ .)
