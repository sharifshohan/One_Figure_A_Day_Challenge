##Load the Libraries
library(ggplot2)
library(readr)
library(RColorBrewer)
library(ggExtra)
#load the data
scoobydoo <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')
table(is.na(scoobydoo$imdb))
scoobydoo <- na.omit(scoobydoo)
str(scoobydoo_new)
#Filter the data to get specific types and seasons only
scoobydoo <- scoobydoo[scoobydoo$motive %in% c("Abduction","Competition","Natural Resource", "Treasure", "Theft"),]
scoobydoo <- scoobydoo[scoobydoo$season %in% c("1","2","3","4"),]
scoobydoo$imdb <- as.numeric(scoobydoo$imdb)
#Check and remove NA values in the dataset
table(is.na(scoobydoo$imdb))
scoobydoo <- na.omit(scoobydoo)
#see the full clean data
View(scoobydoo)
#convert motive to a factor type for grouping
scoobydoo$motive <- as.factor(scoobydoo$motive)
#plot the figure based on motive
g1<- ggplot(data = scoobydoo,aes(x = motive, y = imdb,
           col = motive))+
      geom_boxplot(alpha = 0.3) +
      geom_jitter(alpha = 0.3, size = 2.5)+
      scale_color_brewer(palette = "Dark2")+
      theme_classic()+
      labs(title = "Scooby-Doo Viewer Rating", 
           subtitle = "Grouped by Motive",
           x = "Motive Type",
           y = "IMDB Rating",
           caption = "Source: Scooby-Doo by Sharif")+
      theme(plot.title = element_text(size = 20,
                                      face = "bold",
                                      family = "American Typewriter",
                                      color = "tomato",
                                      hjust = 0.5,
                                      lineheight = 1.2),
            plot.subtitle = element_text(hjust = 0.5))
#Plot figure absed on seasons
g2<- ggplot(data = scoobydoo,aes(x = motive, y = imdb,
                            col = season))+
      geom_boxplot(alpha = 0.3) +
      geom_point(position=position_jitterdodge(), alpha =0.3)+
      scale_color_brewer(palette = "Dark2")+
      theme_classic()+
      labs(title = "Scooby-Doo Viewer Rating", 
           subtitle = "Grouped by Motive and Separated by Season",
           x = "Motive Type",
           y = "IMDB Rating",
           caption = "Source: Scooby-Doo by Sharif")+
      theme(plot.title = element_text(size = 20,
                                      face = "bold",
                                      family = "American Typewriter",
                                      color = "tomato",
                                      hjust = 0.5,
                                      lineheight = 1.2),
            plot.subtitle = element_text(hjust = 0.5))
#Combine the two figure together
gridExtra::grid.arrange(g1,g2)

