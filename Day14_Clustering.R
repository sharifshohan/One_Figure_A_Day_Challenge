library(ggplot2)
library(ggalt)
install.packages("ggfortify")
library(ggfortify)
theme_set(theme_classic())

# Compute data with principal components ------------------
iris
df <- iris[c(1, 2, 3, 4)]
pca_mod <- prcomp(df)  # compute principal components
pca_mod$x
df_pc
# Data frame of principal components ----------------------
df_pc <- data.frame(pca_mod$x, Species=iris$Species)  # dataframe of principal components
df_pc_vir <- df_pc[df_pc$Species == "virginica", ]  # df for 'virginica'
df_pc_set <- df_pc[df_pc$Species == "setosa", ]  # df for 'setosa'
df_pc_ver <- df_pc[df_pc$Species == "versicolor", ]  # df for 'versicolor'

# Plot ----------------------------------------------------
ggplot(df_pc, aes(PC1, PC2, col=Species)) + 
      geom_point(aes(shape=Species), size=2) +   # draw points
      labs(title="Iris Clustering", 
           subtitle="With principal components PC1 and PC2 as X and Y axis",
           caption="Source: Iris") + 
      coord_cartesian(xlim = 1.2 * c(min(df_pc$PC1), max(df_pc$PC1)), 
                      ylim = 1.2 * c(min(df_pc$PC2), max(df_pc$PC2))) +   # change axis limits
      geom_encircle(data = df_pc_vir, aes(x=PC1, y=PC2)) +   # draw circles
      geom_encircle(data = df_pc_set, aes(x=PC1, y=PC2)) + 
      geom_encircle(data = df_pc_ver, aes(x=PC1, y=PC2))

ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
