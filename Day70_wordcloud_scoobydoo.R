library(colorspace)
library(wordcloud2)
library(tm)

scooby <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-13/scoobydoo.csv')


# filter out uninteresting words and interpret "scooby's" as "scooby"
scooby$title <- gsub("Scooby's", "scooby", scooby$title) 
scooby$title <- gsub("and", " ", scooby$title) 
scooby$title <- gsub("The", " ", scooby$title) 
scooby$title <- gsub("the", " ", scooby$title) 
scooby$title <- gsub("for", " ", scooby$title) 
scooby$title <- gsub("from", " ", scooby$title) 
# convert to corpus:
docs <- Corpus(VectorSource(scooby$title))
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove punctuations, but keep apostrophes (e.g. don't, not dont)
docs <- tm_map(docs, removePunctuation, preserve_intra_word_contractions = TRUE)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# create term document matrix
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
# reduce frequeny, so that words fit into graphics device (not ideal!)
d$freq[1:2] <- 30
# use different colors
cols <- hcl.colors(982, palette = "Green-Orange")
set.seed(17721)
w <- wordcloud2(d, size = 1, backgroundColor="black", minSize = 1, color = cols)
w





