##Load the Libraries
library(ggplot2)
library(readr)
library(RColorBrewer)
library(ggExtra)
#load the data
scoobydoo <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')
View(scoobydoo)
scoobydoo$monster_real <- factor(scoobydoo$monster_real, level = c("TRUE","FALSE","NULL"))
scoobydoo$monster_real <- ifelse(scoobydoo$monster_real =="NULL","NA",scoobydoo$monster_real)
table(scoobydoo$series_name)

ggplot(scoobydoo, aes(x = scoobydoo$series_name, y = scoobydoo$season, col = scoobydoo$monster_real))+
      geom_jitter(position = position_jitter(height = .25, width = .3), alpha =0.9, size = 1.4)+
      theme(plot.title = element_text(hjust= 0.5,
                                      face = "bold",
                                      size = 15),
            plot.subtitle = element_text(hjust = 0.5),
            axis.text.x = element_text(hjust = 1,
                                       angle = 45))+
      labs(title= "Is Monster Real or Fake", subtitle = "Scooby-Doo Dataset",
           x = "Name of Series", y = "Season", caption = "Plot: Created by Sharif Shohan")+
      scale_color_discrete(name="Is Monster Real")
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
