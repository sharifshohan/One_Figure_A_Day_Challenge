#load packages
library(tidyverse)
library(tidytuesdayR) #tidytuesday
library(ggplot2) #plots
library(showtext) #add font
library(ragg) #ggsave
library(patchwork) #put together multiple plots
library(ggimage) #image as annotation

#load data
scooby <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')


#clean data 
x <- 
      scooby %>% 
      select(season, title, 
             starts_with("caught"),
             starts_with("captured"),
             starts_with("unmask"),
             starts_with("snack"),
             -contains("other"),
             -contains("not")) %>% 
      filter(title!= "Wrestle Maniacs")

View(x)
char_actions <- x %>% 
      pivot_longer(cols = -c("season","title"), names_to = c(".value","character"), names_sep = "_") %>% 
      mutate(
            across(c("caught","captured","unmask","snack"), ~as.logical(.x) %>% as.integer())
      )

View(char_actions)
##bar graph - frequency of phrases##
#subset to tv shows
seasons <- c("1", "2", "3")
scooby_tv <- scooby %>% filter(season %in% seasons)
#remove null
scooby_tv <- scooby_tv %>% filter(imdb != "NULL")
scooby_tv <- scooby_tv %>% filter(jinkies != "NULL")
#subset to phrases
phrases <- scooby_tv[, c(8,58:65)]
#get year from date
phrases$date_aired <- as.Date(phrases$date_aired, "%Y-%m-%d")
phrases$year <- format(phrases$date_aired, "%Y")
phrases
#change columns to integers
phrases <- phrases %>% mutate(across(c("year", "jeepers","jinkies","my_glasses","just_about_wrapped_up","zoinks", 
                                       "groovy", "scooby_doo_where_are_you", "rooby_rooby_roo"), ~as.integer(.x)))
#group data by year and get sum of counts
phrases_year <- phrases %>% group_by(year) %>% summarise(total_jeepers = sum(jeepers),
                                                         total_jinkies = sum(jinkies),
                                                         total_glasses = sum(my_glasses),
                                                         total_wrapped = sum(just_about_wrapped_up),
                                                         total_zoinks = sum(zoinks),
                                                         total_groovy = sum(groovy),
                                                         total_where = sum(scooby_doo_where_are_you),
                                                         total_rooby = sum(rooby_rooby_roo))
#change columns to rows
View(phrases_year)
phrases_flipped <- as.data.frame(t(phrases_year))
#sum rows
phrases_flipped$total <- rep(0, nrow(phrases_flipped))
for (i in 1:nrow(phrases_flipped)){
      phrases_flipped[i,30] <- sum(phrases_flipped[i,1:29])
}
phrases_flipped2 <- phrases_flipped[2:9,]
phrases_total <- as.data.frame(cbind(rownames(phrases_flipped2), phrases_flipped2$total))
names(phrases_total) <- c("phrase", "total")

##plotting##
#load font
font_add("scooby", "ScoobyDoo.ttf")
showtext_auto()
#bar graph theme
bar_graph_theme <- my_theme <- theme(
      #titles
      plot.title=element_text(family="scooby", size=65, color="black", hjust=1, vjust=1),
      plot.subtitle=element_text(family="scooby", size=30, color="black", hjust=0.5, vjust=1),
      plot.caption=element_text(family="scooby", size=20, color="darkgrey", hjust=0.5, vjust=1),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      #background
      panel.border=element_blank(),
      panel.grid.major.y = element_blank(),
      panel.grid.minor.y = element_blank(),
      panel.background = element_rect(fill = "white"),
      plot.background = element_rect(fill = "white"),
      plot.margin=ggplot2::margin(0.5, 0.5, 0.5, 0.5, "in"),
      #axes
      axis.ticks.length=unit(0.15, "cm"),
      axis.ticks = element_blank(),
      axis.line = element_blank(),
      axis.title = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_text(size=35, family="scooby", colour="black"),
      #no legend
      legend.position = "none")
#colors 
scooby_colors <- c("#006cdc", "#fda42b", "#880008", "#70498a", "#57911d", "#d0afdb", "#89653f", "#00b4d0")
scooby_labels <- c("Where are my glasses?", "Groovy", "Jeepers", "Jinkies!", "Rooby Rooby Roo!", 
                   "Scooby-Doo, where are you?", "Just about wrapped up...", "Zoinks!")
#plot call
phrases_bar <- phrases_total %>% ggplot(aes(x=phrase, y=as.integer(total))) + 
      geom_col(fill=scooby_colors) +
      geom_text(aes(label=total), family="scooby", size=14, hjust=-0.1, color="black") +
      labs(title="|Lot's of Zoinks!!",
           subtitle="Catchphrase said in the series") +
      scale_x_discrete(labels = scooby_labels) +
      coord_flip(clip='off') + bar_graph_theme
phrases_bar

#save plot
ggsave("phrases.png",
       plot=phrases_bar,
       device = agg_png(width = 6, height = 4, units = "in", res = 300))
