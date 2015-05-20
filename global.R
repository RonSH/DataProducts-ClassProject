## Wordcloud of Coursera Data Products Lectures
## Lecture text stored in separate folders organized by week

library(tm)
library(wordcloud)
library(memoise)

# The list of valid lectures
weeks <<- list("Week 1" = "Week1",
               "Week 2" = "Week2",
               "Week 4" = "Week4")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(week) {
        # Careful not to let just any name slip in here; a
        # malicious user could manipulate this value.
        if (!(week %in% weeks))
                stop("Unknown book")
        
        ## Import lecture text into a dataframe
        
        filenames <- list.files(path=week)
        files <- paste(week,filenames,sep="/")
        text <- lapply(files,readLines,encoding="UTF-8")
        
        ## use functions from tm package to "clean" the text
        
        myCorpus = Corpus(VectorSource(text))
        myCorpus = tm_map(myCorpus, content_transformer(tolower))
        ## myCorpus = tm_map(myCorpus, removePunctuation)  
        myCorpus = tm_map(myCorpus, removeNumbers)
        myCorpus = tm_map(myCorpus, removeWords,
                          c(stopwords("SMART"), "lets","heres","nice","type","youre","[sound]"))
        
        myDTM = TermDocumentMatrix(myCorpus,
                                   control = list(minWordLength = 1))
        
        m = as.matrix(myDTM)
        
        sort(rowSums(m), decreasing = TRUE)
})