# create company income statement
category <- c("Sales", "Services", "Fixed Costs", 
              "Variable Costs", "Taxes")
amount <- c(101000, 52000, -23000, -15000, -10000)
income <- data.frame(category, amount) 
# create waterfall chart
library(ggplot2)
install.packages("waterfalls")
library(waterfalls)
waterfall(income)

# create waterfall chart with total column
waterfall(income, 
          calc_total=TRUE, 
          total_axis_text = "Net",
          total_rect_text_color="black",
          total_rect_color="goldenrod1") +
      scale_y_continuous(label=scales::dollar) +
      labs(title = "West Coast Profit and Loss", 
           subtitle = "Year 2017",
           y="", 
           x="") +
      theme_minimal() 
