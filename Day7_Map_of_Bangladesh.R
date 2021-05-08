library(sf)
library(ggplot2)
#install.packages("rgdal")
library(rgdal)
library(rgeos)
#install.packages("gridExtra")
library(gridExtra)
##Download Data File of Bangladesh from following link
## -> https://www.diva-gis.org/gdata

#Reading the shapefiles
sf <- st_read(dsn="BGD_adm/", layer="BGD_adm2")
shape <- readOGR(dsn="BGD_adm", layer="BGD_adm2")
View(sf)
#To view the attributes
head(shape@data)
summary(sf)

#minimalise 
theme_set(theme_minimal())
#Plotting Using ggplot2
map1 <- ggplot() + 
      geom_sf(data = sf, aes(fill = NAME_2)) + theme(legend.position = "none")+
      labs(title="Fragments of Districts", caption = "Bangladesh",
     x="Longitude",y="Lattitude")


map2 <- ggplot()+
      geom_sf(data = sf, aes(fill=NAME_1))+
      labs(title="Divisional Fragments",x="Longitude",y="Lattitude", caption = "Bangladesh")+
      theme(legend.position = "None")

grid.arrange(map1,map2,nrow=1)
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
