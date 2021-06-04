
# Load ggplot2
library(ggplot2)

# Create Data
data <- data.frame(
      group=LETTERS[1:5],
      value=c(13,7,9,21,2)
)

# Basic piechart
ggplot(data, aes(x="", y=value, fill=group)) +
      geom_bar(stat="identity", width=1, color="white") +
      coord_polar("y", start=0) +
      
      theme_void()+ # remove background, grid, numeric labels
      scale_fill_brewer(palette="Set1")
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
