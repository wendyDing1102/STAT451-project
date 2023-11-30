
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
  
  output$trend = renderPlot({ 

    thePlot <- ggplot(air_quality |> 
                        filter(Name==input$name & "Time.Period"==input$time)) +
      geom_bar(aes(x = reorder("Geo.Type.Name", "Data.Value"), y = "Data.Value"),width = 0.6, stat = "identity") +
      labs(
        title = str_c(input$name, " in different geographical types "),
        subtitle = input$time
      )+
      xlab("Geo Type Name")+
      theme_minimal()
    
    thePlot
  })

}
