

#Load the libraries

library(tidyverse)     
library(lubridate)     
library(ggthemes)      
library(ggalt)
library(ggtext)
library(ggplot2)
library(lubridate)
install.packages("waffle")
library(waffle)
theme_set(theme_classic())

#Read the dataset from github repository. This data is also present in tidytuesdayR pacakge
#as well as on kaggle database
scoobydoo <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')
class(scoobydoo)
View(scoobydoo)
View(x)
scoobydoo %>%
      filter(season %in% c("1", "2", "3", "4")) %>% 
      group_by(season) %>% 
      mutate(totengagement = as.numeric(engagement)) %>% 
      na.omit()%>%
      ggplot(mapping = aes(x = totengagement, 
                           y = imdb,
                           color = season)) + 
      geom_point() +
      scale_y_discrete(breaks = c(4,5,6,7,8,9)) +
      scale_color_brewer(palette= "BrBG")+
      labs(x = "Number of people watched the show", 
           y = "IMDb Rating",
           color = "Season No",
           title = "**Number of People Watched Scooby Doo TV Series**",
           caption = "Source:Kaggle Scooby Doo") + 
      theme(plot.title.position = "plot",
            plot.title = element_markdown(family = "mono"),
            plot.caption.position = "plot")
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')

