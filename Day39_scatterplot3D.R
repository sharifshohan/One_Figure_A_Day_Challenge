install.packages("scatterplot3d")
library(scatterplot3d) 
attach(mtcars) 

png(file="out_graph.png")
s3d <-scatterplot3d(wt,disp,mpg, pch=16, highlight.3d=TRUE,
                    type="h", main="3D Scatterplot")
fit <- lm(mpg ~ wt+disp) 
s3d$plane3d(fit)
dev.off()
