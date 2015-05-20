## Wordcloud of Coursera Data Products Lectures


fluidPage(
        # Application title
        titlePanel("Data Products Lectures"),
        
        sidebarLayout(
                # Sidebar selection input
                sidebarPanel(
                        selectInput("selection", "Choose a week:", choices = weeks),
                        actionButton("update", "Change"),
                        hr()
                ),
                
                # Show Word Cloud
                mainPanel(
                        plotOutput("plot")
                )
        )
)