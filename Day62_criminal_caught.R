scoobydoo <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')
library(ggplot2)
library(ggtext)
library(tidyverse)
scoobydoo$date_aired <- as.character(scoobydoo$date_aired)
#Create the data and clean it appropriate
x <- 
      scoobydoo %>% 
      select(season, title, date_aired,
             starts_with("caught"),
             starts_with("captured"),
             starts_with("unmask"),
             starts_with("snack"),
             -contains("other"),
             -contains("not")) %>% 
      filter(title!= "Wrestle Maniacs")
x
str(x)

x %>% pivot_longer(cols = -c("season","title")) %>%
      separate(name,into = c("action","character"), sep = "_")%>% 
      pivot_wider(names_from = "action", values_from = "value")

#Crate a clean dataset with caught information

cleaned_scooby <- x %>% 
      pivot_longer(cols = -c("season","title", "date_aired"), names_to = c(".value","character"), names_sep = "_") %>% 
      mutate(
            across(c("caught","captured","unmask","snack"), ~as.logical(.x) %>% as.integer()) 
      ) %>% 
      na.omit()
cleaned_scooby

#Number of criminal caught by groups
criminal_catches <- cleaned_scooby %>% 
      group_by(character) %>% 
      summarise(caught_criminals = sum(caught))
criminal_catches

#Download images and show the location and size of the fiel
labels = c(
      shaggy = "<img src='ShaggyRogers.png' width='40' /><br>",
      scooby = "<img src='Scooby-Doo.png' width='40' /><br>",
      fred = "<img src='Fred_Jones.png' width='40' /><br>",
      daphnie = "<img src='Daphne_Blake.png' width='40' /><br>",
      velma = "<img src='Velma_Dinkley.png' width='40' /><br>"
)
labels

#Plot using ggplo
ggplot(criminal_catches, aes(character,caught_criminals, fill = ))+
      geom_bar(stat = 'identity', fill = 'steelblue')+
      theme_bw()+
      labs(title = "Most Criminal Caught", y = 'Criminals Caught', caption = 'Plot by Sharif Shohan')+
      scale_x_discrete(name = NULL,labels = labels) +
      theme(axis.text.x = element_markdown())
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
