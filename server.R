library(shiny)
library(ggthemes)

data <- list(co2 = co2, www = WWWusage, death = USAccDeaths)
theme <- list(bw = theme_bw(), 
              five = theme_fivethirtyeight(),
              economist1 = theme_economist(), 
              economist2 = theme_wsj())

source("decomp_ts.R")

shinyServer(function(input, output) {    
      output$plot <- renderPlot({
        p <- ggplot(decomp_ts(data[[input$choice]]), aes(date, value)) +
          geom_line() +
          facet_wrap( ~ type, ncol = 2, scales = "free_y") +
          theme[[input$theme]]      
        print(p)      
    }, height = 400)    
})
