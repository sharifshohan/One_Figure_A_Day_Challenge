# Libraries
library(tidyverse)
library(hrbrthemes)
options(knitr.table.format = "html")
install.packages("babynames")
library(babynames)

library(viridis)


# Load dataset from github
data <- babynames %>% 
      filter(name %in% c("Mary","Emma", "Ida", "Ashley", "Amanda", "Jessica",    "Patricia", "Linda", "Deborah",   "Dorothy", "Betty", "Helen")) %>%
      filter(sex=="F")
View(data)
tmp <- data %>%
      mutate(name2=name)

tmp %>%
      ggplot( aes(x=year, y=n)) +
      geom_line( data=tmp %>% dplyr::select(-name), aes(group=name2), color="grey", size=0.5, alpha=0.5) +
      geom_line( aes(color=name), color="#69b3a2", size=1.2 )+
      scale_color_viridis(discrete = TRUE) +
      theme_ipsum() +
      theme(
            legend.position="none",
            plot.title = element_text(size=14),
            panel.grid = element_blank()
      ) +
      ggtitle("A spaghetti chart of baby names popularity") +
      facet_wrap(~name)
