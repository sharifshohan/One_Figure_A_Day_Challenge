library(ggplot2)
theme_set(theme_bw())
# Prepare data: group mean city mileage by manufacturer.
cty_mpg <- aggregate(mpg$cty, by=list(mpg$manufacturer), FUN=mean)  # aggregate
cty_mpg
mpg
colnames(cty_mpg) <- c("make", "mileage")  # change column names
cty_mpg <- cty_mpg[order(cty_mpg$mileage), ]  # sort
cty_mpg$make <- factor(cty_mpg$make, levels = cty_mpg$make)  # to retain the order in plot.
head(cty_mpg, 4)

# Plot
ggplot(cty_mpg, aes(x=make, y=mileage)) + 
      geom_point(size=3) + 
      geom_segment(aes(x=make, 
                       xend=make, 
                       y=0, 
                       yend=mileage)) + 
      labs(title="Lollipop Chart", 
           subtitle="Make Vs Avg. Mileage", 
           caption="source: mpg") + 
      theme(axis.text.x = element_text(angle=65, vjust=0.6))
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')





