library(tidyverse)
library(ggthemes)
library(ggtext)
library(ggstream)


scoobydoo <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')

scoobydoo <- scoobydoo %>% 
      mutate(year = lubridate::year(date_aired)) %>% 
      mutate_at(c(18:32), as.logical) %>% 
      group_by(year) %>% 
      summarise(scooby = sum(captured_scooby),
                fred = sum(captured_fred),
                daphnie = sum(captured_daphnie),
                velma = sum(captured_velma),
                shaggy = sum(captured_shaggy),
                scooby = sum(captured_scooby),
      ) %>% 
      pivot_longer(cols = 2:6, names_to = "person", 
                   values_to = "n")

scoobydoo
scoobydoo %>% 
      mutate(person = str_to_title(person))%>% 
      ggplot(aes(x = year, y = n, fill = person)) +
      geom_stream(extra_span = 0.2, type = "mirror",
                  true_range = "none", bw = 1) +
      geom_stream_label(aes(label = person), color = "#FFFFFF", 
                        family = "quest") +
      scale_fill_viridis_d(option = "G") +
      labs(x = "Years", y = NULL,
           title = "Scooby-Doo Episodes",
           subtitle = "Captured over years are Homogenous",
           caption = "Made by Sharif") +
      theme(legend.position = "right",
            panel.grid = element_blank(),
            axis.line.y = element_blank(),
            plot.caption = element_markdown(size = 7, 
                                            color = "gray70",
                                            hjust = 1))+
      theme_classic()
