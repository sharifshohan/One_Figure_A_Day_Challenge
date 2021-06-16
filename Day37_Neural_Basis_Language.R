#we are going to plot the data from the paper

load(url("http://dmirman.github.io/FAex.Rdata"))
summary(loadings)
View(loadings)

##First we are going to order the data
Ord <- c(17, 16, 13, 15, 12,  2, 3,  5,  9,  8, 11,  7, 14,  6,  4,  10,  1)
loadings$Test <- reorder(loadings$Test, Ord) 

##Prepare the data
#load the package reshape
library(reshape)
loadings.m <- melt(loadings, id="Test", 
                   measure=c("Semantic Recognition", "Speech Production", 
                             "Speech Recognition", "Semantic Errors"), 
                   variable.name="Factor", value.name="Loading")
#For each test, plot the loading as length and fill color of a bar
# note that the length will be the absolute value of the loading but the 
# fill color will be the signed value, more on this below
ggplot(loadings.m, aes(Test, abs(Loading), fill=Loading)) + 
      facet_wrap(~ Factor, nrow=1) + #place the factors in separate facets
      geom_bar(stat="identity") + #make the bars
      coord_flip() + #flip the axes so the test names can be horizontal  
      #define the fill color gradient: blue=positive, red=negative
      scale_fill_gradient2(name = "Loading", 
                           high = "blue", mid = "white", low = "red", 
                           midpoint=0, guide=F) +
      ylab("Loading Strength") + #improve y-axis label
      theme_bw(base_size=10) #use a black-and0white theme with set font size
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
