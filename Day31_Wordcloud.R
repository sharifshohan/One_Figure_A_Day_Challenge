install.packages("wordcloud2")
# library
library(wordcloud2) 
#Check the inbuilt data
View(demoFreq)
# Gives a proposed palette
my_graph <- wordcloud2(demoFreq, size=1.6, color='random-dark')

# or a vector of colors. vector must be same length than input data
wordcloud2(demoFreq, size=1.6, color=rep_len( c("green","blue"), nrow(demoFreq) ) )

# install webshot
install.packages("webshot")
library(webshot)
webshot::install_phantomjs()


# save it in html
library("htmlwidgets")
saveWidget(my_graph,"tmp.html",selfcontained = F)

# and in png or pdf
webshot("tmp.html","fig_1.pdf", delay =5, vwidth = 480, vheight=480)
