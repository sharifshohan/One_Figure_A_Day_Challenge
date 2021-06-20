# create heatmap for gapminder data (Asia)
library(tidyr)
library(dplyr)
install.packages("superheat")
library(superheat)
# load data
data(gapminder, package="gapminder")

# subset Asian countries
asia <- gapminder %>%
      filter(continent == "Asia") %>%
      select(year, country, lifeExp)

# convert to long to wide format
plotdata <- spread(asia, year, lifeExp)

# save country as row names
plotdata <- as.data.frame(plotdata)
row.names(plotdata) <- plotdata$country
plotdata$country <- NULL

# row order
sort.order <- order(plotdata$"2007")

# color scheme
library(RColorBrewer)
colors <- rev(brewer.pal(5, "Blues"))


# create the heat map
superheat(plotdata,
          scale = FALSE,
          left.label.text.size=3,
          bottom.label.text.size=3,
          bottom.label.size = .05,
          heat.pal = colors,
          order.rows = sort.order,
          title = "Life Expectancy in Asia")
