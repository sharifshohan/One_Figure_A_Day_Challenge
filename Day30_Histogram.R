library(ggplot2)
theme_set(theme_classic())

# Histogram on a Continuous (Numeric) Variable
g <- ggplot(mpg, aes(displ)) + scale_fill_brewer(palette = "Spectral")
require(gridExtra)

plot1<- g + geom_histogram(aes(fill=class), 
                   binwidth = .1, 
                   col="black", 
                   size=.1) +  # change binwidth
      labs(title="Histogram with Auto Binning", 
           subtitle="Engine Displacement across Vehicle Classes")  

plot2<- g + geom_histogram(aes(fill=class), 
                   bins=5, 
                   col="black", 
                   size=.1) +   # change number of bins
      labs(title="Histogram with Fixed Bins", 
           subtitle="Engine Displacement across Vehicle Classes") 
grid.arrange(plot1, plot2, ncol=2)
