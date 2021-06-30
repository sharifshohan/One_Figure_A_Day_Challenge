library(gganatogram)
library(dplyr)
library(gridExtra)
#make a new dataframe 
biopsies <- data.frame(biopsy = c("liver", "heart", "prostate", "stomach", "brain"),
                       x = c(50, 55, 53, 60, 57),
                       y = c(60, 48, 95, 68, 10),
                       value = c(10, 15, 5, 2, 15))
View(biopsies)
View(hgMale_key)
p <- hgMale_key %>%
      dplyr::filter(organ %in% c("liver", "heart", "prostate", "stomach", 
                                 "brain")) %>%
      gganatogram(fillOutline="lightgray", organism="human", sex="male",
                  fill="colour") + theme_void() +
      ggtitle("Position of biopsies")

p <- p + geom_point(data = biopsies, pch=21, size=2, aes(x =x, y = -y,
                                                         fill = biopsy, colour= biopsy))
p2 <- ggplot(biopsies, aes(x = biopsy, y = value, fill = biopsy)) +
      geom_bar(stat= "identity", col="black") +
      theme_minimal() +
      theme(legend.position= "none")+
      theme(axis.text.x = element_text(angle = 60, hjust = 1))+
      ggtitle("Gene1 expression")

p3 <- hgMale_key%>%
      dplyr::filter(organ %in% c("liver", "heart", "prostate", "stomach", 
                                 "brain"))%>%
      gganatogram(fillOutline="lightgray", organism="human", sex="male", 
                  fill="value") + theme_void() +
      ggtitle("Value of biopsies")+
      geom_point(data = biopsies, pch=21, size=3, aes(x =x, y = -y,
                                                      fill = value), colour="red")

lay <- rbind(c(1,2), c(1,2), c(3, NULL))
grid.arrange(p, p3, p2, layout_matrix = lay)