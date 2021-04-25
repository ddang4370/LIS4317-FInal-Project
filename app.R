library(reshape2)
library(tidyverse)
library(ggplot2)

ui <- fluidPage(
    
    sidebarLayout(
        
        sidebarPanel(
            
            selectInput(inputId = "x", label = "Date:",
                        choices = c("Date"),
                        selected = "Date"),
            
            selectInput(inputId = "y", label = "Data:",
                        choices = c("TypeofData","Value"),
                        selected = "Value"),
            
            selectInput(inputId = "z", label = "Shade:",
                        choices = c("TypeofData","Value"),
                        selected = "TypeofData")
        ),
    
        
        #Show Scatterplot           
        mainPanel(
            plotOutput(outputId = "scatterplot")
        )
    )
    
)

server <- function(input, output) {
    
    #bitcoin <- read_csv(file = "BTC-USD.csv")
    #ETH <- read_csv(file = "ETH-USD.csv")
    
    #colnames(bitcoin) <- c("Date_Bit","Open_Bit","High_Bit","Low_Bit","Close_Bit", "Adj_Close_Bit", "Volume_Bit")
    #colnames(ETH) <- c("Date_eth","Open_eth","High_eth","Low_eth","Close_eth", "Adj_Close_eth", "Volume_eth")
    
    #df <- data.frame(bitcoin, ETH)
    
    #melted <- melt(df[,c("Date_Bit","High_Bit","Low_Bit","Close_Bit","Open_eth","High_eth","Low_eth","Close_eth")], id = "Date_Bit")
    
    #colnames(melted) <- c("Date","TypeofData", "Value")
    
    ETH <- read_csv(file = "ETH-USD.csv")
    
    colnames(ETH) <- c("Date_eth","Open_eth","High_eth","Low_eth","Close_eth", "Adj_Close_eth", "Volume_eth")
    
    melted <- melt(df[,c("Date_eth","Open_eth","High_eth","Low_eth","Close_eth")], id = "Date_eth")
    
    colnames(melted) <- c("Date","TypeofData", "Value")
    
    output$scatterplot <- renderPlot({
    ggplot(melted, aes_string(x = input$x, y = input$y, color = input$z, group = input$z)) + ggtitle("Crypto's Volatility") + geom_point()
    
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
