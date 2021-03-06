## Wordcloud of Coursera Data Products Lectures

function(input, output, session) {
        # Define a reactive expression for the document term matrix
        terms <- reactive({
                # Change when the "update" button is pressed...
                input$update
                # ...but not for anything else
                isolate({
                        withProgress({
                                setProgress(message = "Processing lecture text...")
                                getTermMatrix(input$selection)
                        })
                })
        })
        
        # Make the wordcloud drawing predictable during a session
        wordcloud_rep <- repeatable(wordcloud)
        
        output$plot <- renderPlot({
                v <- terms()
                wordcloud_rep(names(v), v, scale=c(4,0.5),
                              min.freq = 10, max.words=50,
                              colors=brewer.pal(8, "Dark2"))
        })
}