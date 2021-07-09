# Libraries
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(viridis)

# The dataset is provided in the gapminder library
library(gapminder)
data <- gapminder %>% filter(year=="2007") %>% dplyr::select(-year)

# Most basic bubble plot
data %>%
      arrange(desc(pop)) %>%
      mutate(country = factor(country, country)) %>%
      ggplot(aes(x=gdpPercap, y=lifeExp, size=pop, fill=continent)) +
      geom_point(alpha=0.5, shape=21, color="black") +
      scale_size(range = c(.1, 24), name="Population (M)") +
      scale_fill_viridis(discrete=TRUE, option="A") +
      theme_ipsum() +
      ylab("Life Expectancy") +
      xlab("Gdp per Capita") 
