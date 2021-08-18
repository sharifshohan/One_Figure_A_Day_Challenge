install.packages("rworldmap")
#Install and load packages

library(rworldmap)
#the countryExData is an inbuilt dataset available in rworldmap dataset
data(countryExData)
library(dplyr)
#checked what are the columns avaialble
colnames(countryExData)
#Tried to subset the dataset sothat I can work with the dataset that is absolutely necessary
x<- countryExData %>%
      select(ISO3V10,Country,BIODIVERSITY,CLIMATE)
#the reason for doing the follwoing line is one dataset i will be working in future
#I will have a dataset that has information for 73 countries
#so I have randomly sampled 73 coubntries from the main  datset and all the columns
x<- x[sample(1:nrow(x), size = 73, replace = FALSE),]
x
#this function is avaialble in the package. I had to jsut follow it. Made sure
# the column name is ISO3V10
sPDF <- joinCountryData2Map( x
                             ,joinCode = "ISO3"
                             ,nameJoinColumn = "ISO3V10")

#Plot the figure
mapCountryData(sPDF
               ,nameColumnToPlot='BIODIVERSITY',
               colourPalette = "terrain")
