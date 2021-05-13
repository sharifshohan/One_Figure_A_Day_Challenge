# load package and data
library(ggplot2)
library(ggExtra)
data(mpg, package="ggplot2")
# mpg <- read.csv("http://goo.gl/uEeRGu")
?mpg
# Scatterplot
theme_set(theme_bw())  # pre-set the bw theme.
mpg_select <- mpg[mpg$hwy >= 35 & mpg$cty > 27, ]
g <- ggplot(mpg, aes(cty, hwy)) + 
      geom_count() + 
      geom_smooth(method="lm", se=F)

ggMarginal(g, type = "histogram", fill="transparent")
#ggMarginal(g, type = "boxplot", fill="transparent")
# ggMarginal(g, type = "density", fill="transparent")
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
