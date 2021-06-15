# Libraries
library(GGally)
# Libraries
library(hrbrthemes)
library(GGally)
library(viridis)
library(gridExtra)
library(ggpubr)

# Data set is provided by R natively
data <- iris

# Plot
x<- ggparcoord(data,
           columns = 1:4, groupColumn = 5, order = "anyClass",
           scale="globalminmax",
           showPoints = TRUE, 
           title = "No scaling",
           alphaLines = 0.3
) + 
      scale_color_viridis(discrete=TRUE) +
      theme_ipsum()+
      theme(
            legend.position="none",
            plot.title = element_text(size=13)
      ) +
      xlab("")
y<- ggparcoord(data,
           columns = 1:4, groupColumn = 5, order = "anyClass",
           scale="uniminmax",
           showPoints = TRUE, 
           title = "Standardize to Min = 0 and Max = 1",
           alphaLines = 0.3
) + 
      scale_color_viridis(discrete=TRUE) +
      theme_ipsum()+
      theme(
            legend.position="none",
            plot.title = element_text(size=13)
      ) +
      xlab("")
z<- ggparcoord(data,
           columns = 1:4, groupColumn = 5, order = "anyClass",
           scale="std",
           showPoints = TRUE, 
           title = "Normalize univariately (substract mean & divide by sd)",
           alphaLines = 0.3
) + 
      scale_color_viridis(discrete=TRUE) +
      theme_ipsum()+
      theme(
            legend.position="none",
            plot.title = element_text(size=13)
      ) +
      xlab("")
a<- ggparcoord(data,
           columns = 1:4, groupColumn = 5, order = "anyClass",
           scale="center",
           showPoints = TRUE, 
           title = "Standardize and center variables",
           alphaLines = 0.3
) + 
      scale_color_viridis(discrete=TRUE) +
      theme_ipsum()+
      theme(
            legend.position="none",
            plot.title = element_text(size=13)
      ) +
      xlab("")
ggarrange(x,y,z,a)
