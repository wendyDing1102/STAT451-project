
library(tidyverse)
library(leaflet)

air_quality <- read.csv("Air_Quality.csv")
function(input, output, session) {

  
  
#  observe({
    theData = reactive({
      
    air_quality |> 
        filter(Name==input$name)
      
    })
 #   updateSelectInput(session,"time", choices = unique(theData()$"Time.Period"))
 # })

    output$timeSelectorUI = renderUI({
      
      selectedPeriods = unique(theData()$Time.Period)

      selectInput("time", "Select time period", 
                  choices = selectedPeriods)
    })

  # Summary 
  
  output$summary = renderText({
    
    paste0(input$name, input$time, " are selected.")
  })
  
  # trend
#  dataplot <- reactive({
#    air_quality |> 
#      filter(Name==input$name & "Time.Period"==input$time)
#    
#  })
#  print(dataplot())
  output$trend = renderPlot({ 

    thePlot = theData() %>%
      filter(Time.Period==input$time) %>%
    ggplot() +
      geom_bar(aes(x=Geo.Type.Name, y=Data.Value), width = 0.6, stat = "identity") +
      labs(
        title = str_c(input$name, " in different geographical types "),
        subtitle = input$time
      )+
      xlab("Geo Type Name")+
      theme_minimal()
    
    print(thePlot)
  })

}
