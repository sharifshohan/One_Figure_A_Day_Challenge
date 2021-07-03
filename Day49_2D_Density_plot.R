# install.packages("ggplot2")
library(ggplot2)

# Data
set.seed(1)
df <- data.frame(x = rnorm(200), y = rnorm(200))
p1<- ggplot(df, aes(x = x, y = y)) +
      geom_point() +
      geom_density_2d_filled(alpha = 0.4) +
      geom_density_2d(colour = "black")
p2<- ggplot(df, aes(x = x, y = y)) +
      geom_density_2d_filled() +
      guides(fill = guide_legend(title = "Level"))
library("gridExtra")
grid.arrange(p1, p2, ncol=2)

