scoobydoo <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')

library(tidyr)
library(dplyr)
library(ggplot2)
#Convert to numberic
colsToConvertNumeric <- names(scoobydoo)[58:65]
#Create DataFrame
convertedDataSayings <- as.data.frame(sapply(X = colsToConvertNumeric, FUN = function(entry){return(as.numeric(scoobydoo[[entry]]))}))
#Clean with tidyr package 
convertedDataSayings
convertedDataSayings$date <- scoobydoo$date_aired
convertedDataSayings$year <- lubridate::year(convertedDataSayings$date)
convertedDataSayings_long <- tidyr::pivot_longer(data = convertedDataSayings, cols = c(-year, -date), names_to = "saying", values_to = "Number of times said")
# Convert 0 entries to NA
convertedDataSayings_long$`Number of times said`[which(convertedDataSayings_long$`Number of times said` == 0)] <- NA
#plot
ggplot(data = convertedDataSayings_long, mapping = aes(x = date, y = saying, size = `Number of times said`)) + geom_point(aes(color = saying)) + 
      theme_bw() + xlab("Year") + ylab("Saying") + scale_color_brewer(palette = "Set2", guide = "none")
