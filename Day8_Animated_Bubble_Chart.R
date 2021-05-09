# Get data:
library(gapminder)

# Charge libraries:
library(ggplot2)
library(gganimate)
View(gapminder)
#country_colors
# Make a ggplot, but add frame=year: one image per year
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
      geom_point(alpha = 0.7, show.legend = FALSE) +
      scale_colour_manual(values = country_colors) +
      scale_size(range = c(2, 12)) +
      scale_x_log10() +
      facet_wrap(~continent) +
      # Here comes the gganimate specific bits
      labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
      transition_time(year) +
      ease_aes('linear')

# Save at gif:
anim_save("271-ggplot2-animated-gif-chart-with-gganimate2.gif")