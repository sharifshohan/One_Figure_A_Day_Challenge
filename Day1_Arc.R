# Load data
dataUU <- read.csv("/Users/mohammadumersharifshohan/Desktop/Visualization_A_day/Day1_Arc_diagram/13_AdjacencyUndirectedUnweighted.csv", header=TRUE, sep = " ")
View(dataUU)
# Transform the adjacency matrix in a long format
connect <- dataUU %>% 
      gather(key="to", value="value", -1) %>%
      mutate(to = gsub("\\.", " ",to)) %>%
      na.omit() 
View(connect)
library(tidyverse)
library(dplyr)
str(connect)
# Number of connection per person
c( as.character(connect$from), as.character(connect$to)) %>%
      as.tibble() %>%
      group_by(value)%>%
      summarize(n=n()) -> coauth

colnames(coauth) <- c("name", "n")
dim(coauth)
coauth
connect
# Create a graph object with igraph
library(igraph)


mygraph <- graph_from_data_frame( connect, vertices = coauth, directed = FALSE )

# Find community
?walktrap.community
com <- walktrap.community(mygraph)
com
com$membership
View(coauth)
#Reorder dataset and make the graph
coauth <- coauth %>% 
      mutate( grp = com$membership) %>%
      arrange(grp) %>%
      mutate(name=factor(name, name))
View(coauth)
# keep only 10 first communities
coauth <- coauth %>% 
      filter(grp<16)

# keep only this people in edges
connect <- connect %>%
      filter(from %in% coauth$name) %>%
      filter(to %in% coauth$name)
connect
# Create a graph object with igraph
mygraph <- graph_from_data_frame( connect, vertices = coauth, directed = FALSE )

# prepare a vector of n color in the viridis scale
mycolor <- colormap(colormap=colormaps$viridis, nshades=max(coauth$grp))
mycolor
mycolor <- sample(mycolor, length(mycolor))

# Make the graph
ggraph(mygraph, layout="linear") + 
      geom_edge_arc(edge_colour="black", edge_alpha=0.2, edge_width=0.3, fold=TRUE) +
      geom_node_point(aes(size=n, color=as.factor(grp), fill=grp), alpha=0.5) +
      scale_size_continuous(range=c(0.5,8)) +
      scale_color_manual(values=mycolor) +
      geom_node_text(aes(label=name), angle=65, hjust=1, nudge_y = -1.1, size=2.3) +
      theme_void() +
      theme(
            legend.position="none",
            plot.margin=unit(c(0,0,0.4,0), "null"),
            panel.spacing=unit(c(0,0,3.4,0), "null")
      ) +
      expand_limits(x = c(-1.2, 1.2), y = c(-5.6, 1.2)) 
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
