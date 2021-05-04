library(ggplot2)
library(ggthemes)
options(scipen = 999)  # turns of scientific notations like 1e+40

# Read data
email_campaign_funnel <- read.csv("/Users/mohammadumersharifshohan/Desktop/Visualization_A_day/Day3_population_pyramid/email_campaign_funnel.csv", header = TRUE)
View(email_campaign_funnel)
# X Axis Breaks and Labels 
brks <- seq(-15000000, 15000000, 5000000)
brks
lbls = paste0(as.character(c(seq(15, 0, -5), seq(5, 15, 5))), "m")
paste0(as.character(c(seq(15, 0, -5), seq(5, 15, 5))), "m")

lbls
# Plot
ggplot(email_campaign_funnel, aes(x = Stage, y = Users, fill = Gender)) +   # Fill column
      geom_bar(stat = "identity", width = .6) +   # draw the bars
      scale_y_continuous(breaks = brks,   # Breaks
                         labels = lbls) + # Labels
      coord_flip() +  # Flip axes
      labs(title="Email Campaign Funnel") +
      theme_tufte() +  # Tufte theme from ggfortify
      theme(plot.title = element_text(hjust = .5), 
            axis.ticks = element_blank()) +   # Centre plot title
      scale_fill_brewer(palette = "Dark2")  # Color palette
