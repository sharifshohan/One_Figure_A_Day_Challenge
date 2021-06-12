# Prepare data: group mean city mileage by manufacturer.
cty_mpg <- aggregate(mpg$cty, by=list(mpg$manufacturer), FUN=mean)  # aggregate
colnames(cty_mpg) <- c("make", "mileage")  # change column names
cty_mpg <- cty_mpg[order(cty_mpg$mileage), ]  # sort
cty_mpg$make <- factor(cty_mpg$make, levels = cty_mpg$make)  # to retain the order in plot.
head(cty_mpg, 4)
library(ggplot2)
library(scales)
theme_set(theme_classic())

# Plot
ggplot(cty_mpg, aes(x=make, y=mileage)) + 
      geom_point(col="tomato2", size=3) +   # Draw points
      geom_segment(aes(x=make, 
                       xend=make, 
                       y=min(mileage), 
                       yend=max(mileage)), 
                   linetype="dashed", 
                   size=0.1) +   # Draw dashed lines
      labs(title="Dot Plot", 
           subtitle="Make Vs Avg. Mileage", 
           caption="source: mpg") +  
      coord_flip()
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
