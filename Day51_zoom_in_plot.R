library(ggforce)
library(tidyverse)
theme_set(theme_bw(16))


# Load data from TidyTuesday github
astronauts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-14/astronauts.csv')
View(astronauts)

#Basic ggplot
astronauts %>% 
      ggplot(aes(x=year_of_mission,hours_mission, color=sex))+
      geom_point()+
      scale_y_log10()


###Zoom in using ggforce package
astronauts %>% 
      ggplot(aes(x=year_of_mission,hours_mission, color=sex))+
      geom_point()+
      scale_y_log10()+
      facet_zoom(xlim = c(1965, 1985))
