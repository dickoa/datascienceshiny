library(shiny)
library(htmltools)

data <- list(co2 = co2, www = WWWusage, death = USAccDeaths)
shinyUI(pageWithSidebar(    
    headerPanel("Automatic decomposition of time series"),
    
    
    sidebarPanel(       
      
      helpText(strong(br("This app allow you to extract the trend and when 
available the seasonality from any time series."),
                      "Select a time series to get started")),
      
        selectInput('choice', strong('time series :'), names(data)),                
        selectInput('theme', strong('ggplot theme :'), c("Black and White" = "bw",
                                                   "538" = "five",
                                                 "economist1",
                                                 "economist2")),  
        
        helpText(strong(br("This decomposition algorithm"),
                 "is a modification of the original code of Rob J. Hyndman", 
                 a("(link)", href = "http://robjhyndman.com/hyndsight/tscharacteristics"),
                 br(a("full code on github", href = "http://robjhyndman.com/hyndsight/tscharacteristics"))))
    ),    
    mainPanel(
        plotOutput('plot')
    )
))
