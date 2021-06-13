library(readr)
library(tidyverse)
library(tidygraph)
library(ggraph)
## Download the file from the https://github.com/mathbeveridge/asoiaf

path <- "/Users/mohammadumersharifshohan/Desktop/Visualization_A_day/Day35_Gameofthrones_network/data/"
files <- list.files(path = path, full.names = TRUE)
files

#The dataset I am going to use is based on the interacton on all the books
#The data is prepared connecting two characters whenever their names (or nicknames) 
#appeared within 15 words of one another

cooc_all_edges <- read_csv(files[1])
View(cooc_all_edges)
#Here we are subsetting the number of character to 100

#grouping the data based on weight
main_ch<- cooc_all_edges %>%
      select(-Type) %>%
      gather(x, name, Source: Target)%>%
      group_by(name) %>%
      summarise(sum_weight = sum(weight))%>%
      ungroup()
View(main_ch)
#ordering and taking the top 100 important interaction

main_ch_l <- main_ch %>%
      arrange(desc(sum_weight)) %>%
      top_n(100, sum_weight)
View(main_ch_l)

#Filter the main characters from the original data 

cooc_all_f <- cooc_all_edges %>%
      filter(Source %in% main_ch_l$name & Target %in% main_ch_l$name)
View(cooc_all_f)

#Now we try to create the nide for each of the data


#Now we will be ranking the nodes of our current data
#Need a package to install for the following code
install.packages("seriation")
library(seriation)

##We try to create the centrality. it describes the edges in or outgoing fromnode

##Grouping and clustering

##We can check the query node types

#Check the node pairs

# we can check the edge betweenness


#looking at everything together

cooc_all_f_graph <- as_tbl_graph(cooc_all_f, directed = FALSE) %>%
      mutate(n_rank_trv = node_rank_traveller(),
             neighbors = centrality_degree(),
             group = group_infomap(),
             center = node_is_center(),
             dist_to_center = node_distance_to(node_is_center()),
             keyplayer = node_is_keyplayer(k = 10)) %>%
      activate(edges) %>% 
      filter(!edge_is_multiple()) %>%
      mutate(centrality_e = centrality_edge_betweenness())
cooc_all_f_graph %>%
      activate(nodes) %>% # %N>%
      as.tibble()
#now plotting the ggraph
layout <- create_layout(cooc_all_f_graph, 
                        layout = "fr")

#Plottin the graph
cols <- RColorBrewer::brewer.pal(3, "Set1")
ggraph(layout) + 
      geom_edge_density(aes(fill = weight)) +
      geom_edge_link(aes(width = weight), alpha = 0.2) + 
      geom_node_point(aes(color = factor(center), size = dist_to_center)) +
      geom_node_text(aes(label = name), size = 8, repel = TRUE) +
      scale_colour_manual(values = c(cols[2], cols[1])) +
      theme_graph() +
      labs(title = "A Song of Ice and Fire character network",
           subtitle = "Nodes are colored by centeredness")
ggsave("test.tiff", units="in", width=30, height=30, dpi=300, compression = 'lzw')
