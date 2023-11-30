
library(tidyverse)
library(leaflet)

air_quality <- read.csv("Air_Quality.csv")
function(input, output, session) {

  
  
  observe({
    theData = reactive({
      
    air_quality |> 
        filter(Name==input$name)
      
    })
    updateSelectInput(session,"time", choices = unique(theData()$"Time.Period"))
  })

  # Summary 
  
  output$summary = renderText({
    
    paste0(input$name, input$time, " are selected.")
  })
  
  # trend
  dataplot <- reactive({
    air_quality |> 
      filter(Name==input$name & "Time.Period"==input$time)
    
  })
  print(dataplot())
  output$trend = renderPlot({ 

    thePlot <- ggplot(dataplot()) +
      geom_bar(aes(x =dataplot()$Geo.Type.Name, y = dataplot()$Data.Value),width = 0.6, stat = "identity") +
      labs(
        title = str_c(input$name, " in different geographical types "),
        subtitle = input$time
      )+
      xlab("Geo Type Name")+
      theme_minimal()
    
    thePlot
  })

}
