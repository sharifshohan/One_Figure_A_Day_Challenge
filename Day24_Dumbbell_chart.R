library(ggplot2)
library(ggalt)
theme_set(theme_classic())

health <- read.csv("https://raw.githubusercontent.com/selva86/datasets/master/health.csv")
health$Area <- factor(health$Area, levels=as.character(health$Area))  # for right ordering of the dumbells
health
health$Area <- factor(health$Area)
gg <- ggplot(health, aes(x=pct_2013, xend=pct_2014, y=Area, group=Area)) + 
      geom_dumbbell(colour_x = "#0e668b",
                    colour_xend = "#a3c4dc", 
                    size=0.75) +
      labs(x=NULL, 
           y=NULL, 
           title="Dumbbell Chart", 
           subtitle="Pct Change: 2013 vs 2014", 
           caption="Source: https://github.com/sharifshohan/One_Figure_A_Day_Challenge") +
      theme(plot.title = element_text(hjust=0.5, face="bold"),
            plot.background=element_rect(fill="#f7f7f7"),
            panel.background=element_rect(fill="#f7f7f7"),
            panel.grid.minor=element_blank(),
            panel.grid.major.y=element_blank(),
            panel.grid.major.x=element_line(),
            axis.ticks=element_blank(),
            legend.position="top",
            panel.border=element_blank())
plot(gg)
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')

