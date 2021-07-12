##insall and load packages
library(tidyverse)
install.packages("palmerpenguins")
library(palmerpenguins)
library(Rtsne)
#Set theme
theme_set(theme_bw(18))

#load data and clean
penguins <- penguins %>% 
      drop_na() %>%#dropping Na values
      select(-year)%>%#removing yr
      mutate(ID=row_number())  #Adding row numbercolumn
View(penguins)

#Create a meta data of the same penguins data
penguins_meta <- penguins %>%
      select(ID,species,island,sex)

#Performing tSNE with Rtsne package
#At first you will need to get only the data that is numeric in order 
#to work with it
set.seed(142)
tSNE_fit <- penguins %>%
      select(where(is.numeric)) %>%
      column_to_rownames("ID") %>%
      scale() %>% 
      Rtsne()

#We are interested in tsne1 and tsne2 for the data frame
# so we convert this into a data frame
tSNE_df <- tSNE_fit$Y %>% 
      as.data.frame() %>%
      rename(tSNE1="V1",
             tSNE2="V2") %>%
      mutate(ID=row_number())
View(tSNE_df)

#Merge data by a column value
tSNE_df <- tSNE_df %>%
      inner_join(penguins_meta, by="ID")
View(tSNE_df)

tSNE_df %>%
      ggplot(aes(x = tSNE1, 
                 y = tSNE2,
                 color = species,
                 shape = sex))+
      geom_point()+
      theme(legend.position="bottom")
ggsave("tSNE_plot_example1.png")
