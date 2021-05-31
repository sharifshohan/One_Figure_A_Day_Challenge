#Load the libraries
library(ggthemes)
library(ggplot2)

#Read the file
flower <- read.csv("flower_data.csv", header = TRUE)
#Setting the theme
theme_set(theme_classic())
#Plot density plot

 p<- ggplot(flower) + 
      geom_density(aes(x = flowers, fill = nitrogen), alpha = 0.5) +
      labs(y = "Density", x = "Number of Flowers", fill = "Nitrogen\nConcentration") +
      scale_fill_manual(labels = c("High", "Medium", "Low"),
                        values = c("#DB24BC", "#BCDB24", "#24BCDB")) 
p
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
