# Library
library(tidyverse)

# Data
a <- data.frame( x=rnorm(20000, 10, 1.9), y=rnorm(20000, 10, 1.2) )
b <- data.frame( x=rnorm(20000, 14.5, 1.9), y=rnorm(20000, 14.5, 1.9) )
c <- data.frame( x=rnorm(20000, 9.5, 1.9), y=rnorm(20000, 15.5, 1.9) )
data <- rbind(a,b,c)

data
# Hexbin chart with default option
ggplot(data, aes(x=x, y=y) ) +
      geom_hex() +
      theme_bw()

# Bin size control + color palette
ggplot(data, aes(x=x, y=y) ) +
      geom_hex(bins = 70) +
      scale_fill_continuous(type = "viridis") +
      theme_bw()
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
