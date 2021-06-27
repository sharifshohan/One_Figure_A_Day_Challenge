# install.packages("remotes")
remotes::install_github("davidsjoberg/ggstream")
library(ggstream)
# install.packages("ggplot2")
library(ggplot2)
View(blockbusters)
cols <- c("#FFB400", "#FFC740", "#C20008", "#FF020D", "#13AFEF")

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
      geom_stream(color = 1, lwd = 0.25) +
      scale_fill_manual(values = cols) +
      theme_minimal()
