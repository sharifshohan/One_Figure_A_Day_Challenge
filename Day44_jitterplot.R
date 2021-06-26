# load package and data
library(ggplot2)
library(gridExtra)
data(mpg, package="ggplot2") # alternate source: "http://goo.gl/uEeRGu")
theme_set(theme_bw())  # pre-set the bw theme.

g <- ggplot(mpg, aes(cty, hwy))

# Scatterplot
p1<- g + geom_point() + 
      geom_smooth(method="lm", se=F) +
      labs(subtitle="mpg: city vs highway mileage", 
           y="hwy", 
           x="cty", 
           title="Scatterplot with overlapping points", 
           caption="Source: midwest")
# load package and data
library(ggplot2)
data(mpg, package="ggplot2")
# mpg <- read.csv("http://goo.gl/uEeRGu")

# Scatterplot
theme_set(theme_bw())  # pre-set the bw theme.
g <- ggplot(mpg, aes(cty, hwy))
p2<- g + geom_jitter(width = .5, size=1) +
      labs(subtitle="mpg: city vs highway mileage", 
           y="hwy", 
           x="cty", 
           title="Jittered Points")
grid.arrange(p1, p2, nrow = 1)

