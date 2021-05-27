library(dplyr)
library(tidyr)     # For drop_na function
install.packages("gcookbook")
library(gcookbook) # For the data set

# Set random seed to make random operation below repeatable
set.seed(392)

c2 <- countries %>%
      filter(Year == 2009) %>%  # Get data from year 2009
      drop_na() %>%             # Drop rows that have any NA values
      sample_n(25)              # Select 25 random rows

c2
#Changing the rownames with the name column
rownames(c2) <- c2$Name
##We need to select columns that are important for analysis
c2 <- c2[, 4:7]

##For minimising the effect of one particular variable in the whole
##analysis, we will need to scale the data
c3 <- scale(c2)
c3
c2

#Now we are ready to make the dendogram
hc <- hclust(dist(c3))

# Make the dendrogram
plot(hc)

# With text aligned
plot(hc, hang = -1)
