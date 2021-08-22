# Load packages
library(tidyverse)

library(showtext) # For fonts
install.packages("showtext")
library(waffle)
# Note: had to install {waffle} via below line.
install.packages("waffle", repos = "https://cinc.rud.is")
# devtools::install_github("hrbrmstr/waffle") returned an error

# Read in data
scoobydoo <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')
head(scoobydoo)

# Get number of caught monsters per character
catches_per_character <- scoobydoo %>% 
      select(-caught_not) %>% # Remove data where the monster wasn't caught
      mutate(across(starts_with("caught"), ~na_if(.x, "NULL")),
             across(starts_with("caught"), as.logical)) %>% 
      pivot_longer(starts_with("caught"), names_to = "catcher", values_to = "caught") %>% 
      group_by(catcher) %>% 
      summarize(n_caught = sum(caught, na.rm = TRUE)) %>% 
      ungroup() %>% 
      mutate(catcher = word(catcher, 2, sep = "_"), # Extract name only
             catcher = str_to_title(catcher)) %>% # Capitalize name 
      arrange(desc(n_caught))

# Make color palette
pal <- c("#128a84",
         "#79af30",
         "#ffe97f",
         "#bb5c37",
         "#4b0055",
         "#8e6345")

# Plotty plot - let's waffle

## The basic way
waffle(deframe(catches_per_character), 
       title = "Monster Caught by Character",
       rows = 15,
       colors = pal
)
