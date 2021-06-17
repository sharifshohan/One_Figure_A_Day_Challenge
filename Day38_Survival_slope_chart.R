library(dplyr)
library(ggplot2)
theme_set(theme_classic())
source_df <- read.csv("https://raw.githubusercontent.com/jkeirstead/r-slopegraph/master/cancer_survival_rates.csv")
View(source_df)
# Define functions. Source: https://github.com/jkeirstead/r-slopegraph
tufte_sort <- function(df, x="year", y="value", group="group", method="tufte", min.space=0.05) {
      ## First rename the columns for consistency
      ids <- match(c(x, y, group), names(df))
      df <- df[,ids]
      names(df) <- c("x", "y", "group")
      
      ## Expand grid to ensure every combination has a defined value
      tmp <- expand.grid(x=unique(df$x), group=unique(df$group))
      tmp <- merge(df, tmp, all.y=TRUE)
      df <- mutate(tmp, y=ifelse(is.na(y), 0, y))
      
      ## Cast into a matrix shape and arrange by first column
      require(reshape2)
      tmp <- dcast(df, group ~ x, value.var="y")
      ord <- order(tmp[,2])
      tmp <- tmp[ord,]
      
      min.space <- min.space*diff(range(tmp[,-1]))
      yshift <- numeric(nrow(tmp))
      ## Start at "bottom" row
      ## Repeat for rest of the rows until you hit the top
      for (i in 2:nrow(tmp)) {
            ## Shift subsequent row up by equal space so gap between
            ## two entries is >= minimum
            mat <- as.matrix(tmp[(i-1):i, -1])
            d.min <- min(diff(mat))
            yshift[i] <- ifelse(d.min < min.space, min.space - d.min, 0)
      }
      
      
      tmp <- cbind(tmp, yshift=cumsum(yshift))
      
      scale <- 1
      tmp <- melt(tmp, id=c("group", "yshift"), variable.name="x", value.name="y")
      ## Store these gaps in a separate variable so that they can be scaled ypos = a*yshift + y
      
      tmp <- transform(tmp, ypos=y + scale*yshift)
      return(tmp)
      
}

plot_slopegraph <- function(df) {
      ylabs <- subset(df, x==head(x,1))$group
      yvals <- subset(df, x==head(x,1))$ypos
      fontSize <- 3
      gg <- ggplot(df,aes(x=x,y=ypos)) +
            geom_line(aes(group=group),colour="grey80") +
            geom_point(colour="white",size=8) +
            geom_text(aes(label=y), size=fontSize, family="American Typewriter") +
            scale_y_continuous(name="", breaks=yvals, labels=ylabs)
      return(gg)
}    

## Prepare data    
df <- tufte_sort(source_df, 
                 x="year", 
                 y="value", 
                 group="group", 
                 method="tufte", 
                 min.space=0.05)

df <- transform(df, 
                x=factor(x, levels=c(5,10,15,20), 
                         labels=c("5 years","10 years","15 years","20 years")), 
                y=round(y))

## Plot
plot_slopegraph(df) + labs(title="Estimates of % survival rates") + 
      theme(axis.title=element_blank(),
            axis.ticks = element_blank(),
            plot.title = element_text(hjust=0.5,
                                      family = "American Typewriter",
                                      face="bold"),
            axis.text = element_text(family = "American Typewriter",
                                     face="bold"))
