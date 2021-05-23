View(presidents)
pres_rating <- data.frame(
      rating = as.numeric(presidents),
      year = as.numeric(floor(time(presidents))),
      quarter = as.numeric(cycle(presidents))
)
pres_rating

# Base plot
p <- ggplot(pres_rating, aes(x = year, y = quarter, fill = rating))
p
# Using geom_tile()
p + geom_tile()

# Using geom_raster() - looks the same, but a little more efficient
p + geom_raster()
p

p +
      geom_tile() +
      scale_x_continuous(breaks = seq(1940, 1976, by = 4), expand = c(0, 0)) +
      scale_y_reverse(expand = c(0, 0)) +
      scale_fill_gradient2(midpoint = 50, mid = "grey70", limits = c(0, 100))
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
