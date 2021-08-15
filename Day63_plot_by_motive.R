library(tidyverse)
library(ggthemes)
library(viridis)
library(gridExtra)
library(ggplot2)

#load the csv file from resource
scoobydoo <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')
#check the file
scoobydoo

scoobydoo <- scoobydoo[!scoobydoo$motive == "NULL",] # removes NULL motives so only motive
scoobydoo <- scoobydoo %>% filter(str_detect(series_name, "Scooby*"))# only series that had scooy in the name

#count the motives based on series
df <- scoobydoo %>% count(series_name, motive, sort = TRUE)
df
#count overal motive
df1 <-  scoobydoo %>% count(motive, sort = TRUE)
df1
#Scooby-doo motives by series
sg <- ggplot(df, aes(x=reorder(motive, n),label= n,  y= n, fill=series_name)) + 
      geom_bar(stat="identity") + 
      coord_flip() +
      geom_text(position=position_stack(0.5), color="white") + 
      theme_fivethirtyeight() + 
      labs(title = "Most Common Scooby-Doo Motives by Series", x=  "Motives", y = "Number of Motives",
          caption = "Plot by Sharif") +
      guides(fill=guide_legend("Series Name")) + 
      scale_fill_viridis(option ="turbo",discrete = TRUE) + 
      theme(legend.position = "right",legend.direction = "vertical")
sg

#Most common scoobydoo motives
sg2 <- ggplot(df1, aes(x=reorder(motive, n),label= n,  y= n, fill=motive)) + 
      geom_bar(stat="identity") + 
      coord_flip() +
      geom_text(hjust=0, color="black") + 
      theme_fivethirtyeight() + 
      labs(title = "Most Common Scooby-Doo Motives", x=  "Motives", y = "Number of Motives", 
         caption = "Plot by sharif") + 
      guides(fill=guide_legend("Motives"))+ 
      scale_fill_viridis(option = "inferno",discrete = TRUE) + 
      theme(legend.position = "right",legend.direction = "vertical")
sg2
grid.arrange(sg,sg2)
