library(tidyverse)
library(viridis)
library(patchwork)
library(hrbrthemes)
library(circlize)
install.packages("networkD3")
library(networkD3)
# Load dataset from github
data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/13_AdjacencyDirectedWeighted.csv", header=TRUE)
View(data)
# Package
library(networkD3)

# I need a long format
data_long <- data %>%
      rownames_to_column %>%
      gather(key = 'key', value = 'value', -rowname) %>%
      filter(value > 0)
View(data_long)
colnames(data_long) <- c("source", "target", "value")
data_long$target <- paste(data_long$target, " ", sep="")

# From these flows we need to create a node data frame: it lists every entities involved in the flow
nodes <- data.frame(name=c(as.character(data_long$source), as.character(data_long$target)) %>% unique())
nodes
# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
data_long$IDsource=match(data_long$source, nodes$name)-1 
data_long$IDtarget=match(data_long$target, nodes$name)-1
View(data_long)
# prepare colour scale
ColourScal ='d3.scaleOrdinal() .range(["#FDE725FF","#B4DE2CFF","#6DCD59FF","#35B779FF","#1F9E89FF","#26828EFF","#31688EFF","#3E4A89FF","#482878FF","#440154FF"])'
jpeg( filename = "Sankey.jpg", width = 4000, height = 4000)

# Make the Network
sankeyNetwork(Links = data_long, Nodes = nodes,
              Source = "IDsource", Target = "IDtarget",
              Value = "value", NodeID = "name", 
              sinksRight=FALSE, colourScale=ColourScal, nodeWidth=40, fontSize=13, nodePadding=20)
dev.off()
#install pacakge for saving
install.packages("rbokeh")
library(rbokeh)

#save the figure
widget2png(sn, "sankey.png")
