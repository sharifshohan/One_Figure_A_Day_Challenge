library(tidyverse)
theme_set(theme_bw(16))
library(ggplot2)
install.packages("PupillometryR")
library(PupillometryR)
p2data <- "https://raw.githubusercontent.com/datavizpyr/data/master/palmer_penguin_species.tsv"

penguins_df <- read_tsv(p2data)
View(penguins_df)
#First create Half violin plot
ggplot(penguins_df, aes(species,
                        flipper_length_mm, 
                        fill=species)) +
      geom_flat_violin() +
      coord_flip()+
      theme(legend.position="none")

##Horizontal Half Violin Plots with jittered data points
ggplot(penguins_df, aes(species, 
                        flipper_length_mm,
                        fill=species)) +
      geom_flat_violin() +
      coord_flip()+
      geom_jitter()+
      theme(legend.position="none")
#Rain Cloud plots: Combining Horizontal Half Violin Plots with jittered data points

ggplot(penguins_df, aes(species,flipper_length_mm, fill=species)) +
      geom_flat_violin(position = position_nudge(x = .2, y = 0)) +
      coord_flip()+
      geom_jitter(width=0.15)+
      theme(legend.position="none")

##Lets color the plot
ggplot(penguins_df, aes(species,flipper_length_mm, fill=species)) +
      geom_flat_violin(position = position_nudge(x = .2, y = 0)) +
      coord_flip()+
      geom_jitter(aes(color = species),
                  width=0.15, alpha = 0.6)+
      theme(legend.position="none")




