# Libraries
library(tidyverse)
library(hrbrthemes)
library(viridis)

# create a dataset
data <- data.frame(
      name=c( rep("A",500), rep("B",500), rep("B",500), rep("C",20), rep('D', 100)  ),
      value=c( rnorm(500, 10, 5), rnorm(500, 13, 1), rnorm(500, 18, 1), rnorm(20, 25, 4), rnorm(100, 12, 1) )
)
View(data)
?rnorm
nrow(data)
theme_set(theme_bw())
# Plot
data %>%
      ggplot( aes(x=name, y=value, fill=name)) +
      geom_boxplot() +
      scale_fill_viridis(discrete = TRUE, alpha=0.6) +
      geom_jitter(color="black", size=0.4, alpha=0.9) +
      theme(
            legend.position="none",
            plot.title = element_text(size=11)
      ) +
      ggtitle("A boxplot with jitter") +
      xlab("")
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')

