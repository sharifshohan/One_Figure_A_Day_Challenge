library(ggplot2)
library(dplyr)
library(RColorBrewer)
#load the csv file from resource
scoobydoo <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')

scoobydoo$year <- format(scoobydoo$date_aired, format = "%Y")

scoob <- scoobydoo[(scoobydoo$monster_gender =="Male"| scoobydoo$monster_gender == "Female"),]
?geom_bar

ggplot(scoob, aes(x = factor(monster_gender), fill = monster_gender))+
      geom_bar()+
      facet_wrap(~year)+
      labs(title = "Gender of Monster by Year",
           subtitle = "Data from ScoobyDoo",
           x = "Monster Gender",
           y = "Number of Monster",
           caption = "Plot by Sharif")+
      scale_fill_brewer(palette = "Set1")+
      theme(plot.title = element_text(face = "bold",
                                      size =18,
                                      hjust = 0.5,
                                      color ="orangered4"))
      
      
