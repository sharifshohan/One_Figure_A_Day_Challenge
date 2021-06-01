library(ggplot2)
install.packages("treemapify")
library(treemapify)
##G20 dataset 
G20

#Draw a basic treemap
ggplot(G20, aes(area = gdp_mil_usd, fill = hdi)) +
      geom_treemap()
##Advanced with names and texts
ggplot(G20, aes(area = gdp_mil_usd, fill = hdi, label = country)) +
      geom_treemap() +
      geom_treemap_text(fontface = "italic", colour = "white", place = "centre",
                        grow = TRUE)

#Subgrouping tiles
ggplot(G20, aes(area = gdp_mil_usd, fill = hdi, label = country,
                subgroup = region)) +
      geom_treemap() +
      geom_treemap_subgroup_border() +
      geom_treemap_subgroup_text(place = "centre", grow = T, alpha = 0.5, colour =
                                       "black", fontface = "italic", min.size = 0) +
      geom_treemap_text(colour = "white", place = "topleft", reflow = T)


ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')

