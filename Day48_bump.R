year <- rep(2019:2021, 4)
position <- c(4, 2, 2, 3, 1, 4, 2, 3, 1, 1, 4, 3)
player <- c("A", "A", "A",
            "B", "B", "B", 
            "C", "C", "C",
            "D", "D", "D")

df <- data.frame(x = year,
                 y = position,
                 group = player)
# install.packages("tidyverse")
install.packages("ggbump")
library(tidyverse)
library(ggbump)

ggplot(df, aes(x = x, y = y, color = group)) +
      geom_bump(size = 1.5) +
      geom_point(size = 6) +
      geom_text(data = df %>% filter(x == min(x)),
                aes(x = x - 0.1, label = group),
                size = 5, hjust = 1) +
      geom_text(data = df %>% filter(x == max(x)),
                aes(x = x + 0.1, label = group),
                size = 5, hjust = 0) +
      scale_color_brewer(palette = "RdBu") +
      scale_x_continuous(breaks = c(2019, 2020, 2021))+
      theme_classic() +
      theme(legend.position = "none")
