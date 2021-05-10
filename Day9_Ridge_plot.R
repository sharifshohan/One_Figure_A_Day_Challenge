# library
library(ggridges)
library(ggplot2)

# Diamonds dataset is provided by R natively
head(diamonds)
View(as.data.frame(diamonds))
# basic example
ggplot(diamonds, aes(x = price, y = cut, fill = cut)) +
      geom_density_ridges() +
      theme_ridges() + 
      theme(legend.position = "none")
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
