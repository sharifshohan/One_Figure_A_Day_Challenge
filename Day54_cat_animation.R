# install.packages("Ecdat")
library(Ecdat)
# install.packages("tidyverse")
library(tidyverse)
# install.packages("gganimate")
library(gganimate)
# install.packages("remotes")
remotes::install_github("R-CoderDotCom/ggcats@main")
library(ggcats)

# Data frame
dat <-
      incomeInequality %>%
      select(Year, P99, median) %>%
      rename(income_median = median,
             income_99percent = P99) %>%
      pivot_longer(cols = starts_with("income"),
                   names_to = "income",
                   names_prefix = "income_")

# Cats for each line
dat$cat <- rep(NA, 132)
dat$cat[which(dat$income == "median")] <- "nyancat"
dat$cat[which(dat$income == "99percent")] <- rep(c("pop_close", "pop"), 33)

# Animation
p<-ggplot(dat, aes(x = Year, y = value, group = income, color = income)) +
      geom_line(size = 2) +
      ggtitle("ggcats, a core package of the memeverse") +
      geom_cat(aes(cat = cat), size = 5) +
      xlab("Cats") +
      ylab("Cats") +
      theme(legend.position = "none",
            plot.title = element_text(size = 20),
            axis.text = element_blank(),
            axis.ticks = element_blank()) +
      transition_reveal(Year)
anim_save("filenamehere.gif", p)



