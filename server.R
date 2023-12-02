
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
  
  output$time_series=renderPlot({
    df_1 <- air_quality %>%
      filter(Name == input$indicator, Geo.Place.Name == input$location) %>%
      separate(Time.Period, into = c("time", "year"), sep = "(?<=\\D)(?=\\d)", extra = "merge") %>%
      mutate(year = as.numeric(trimws(year)), time = trimws(time)) %>%
      filter(time == "Annual Average") %>%
      arrange(year)
    
    theplot <- ggplot(data = df_1, aes(x = year, y = Data.Value)) +
      geom_line() +  
      geom_point(size = 3) +  
      geom_hline(yintercept = 0, color = "black", size = 1.5) + 
      scale_x_continuous(breaks = seq(min(df_1$year), max(df_1$year), by = 2)) +
      ylim(0, max(df_1$Data.Value, na.rm = TRUE) + 2) +
      theme_minimal() +
      labs(x = "Year", y = "Mean concentration in ppb (parts per billion)", 
           title = paste("Annual Average", input$indicator, "Data Value Over Years\
                         in whole NY (2009 - 2021)")) +
      theme(axis.text.x = element_text(vjust = 0.5, hjust = 0.5, size = 13),
            axis.title.x = element_text(vjust = 0.5, hjust = 0.5, size = 15),
            axis.text.y = element_text(vjust = 0.5, hjust = 0.5, size = 13),
            axis.title.y = element_text(vjust = 0.5, hjust = 0.5, size = 15),
            plot.title = element_text(size = 20, hjust = 0.3),
            plot.caption = element_text(size = 9))
    
    print(theplot)
  })
  
  output$coorelation=renderPlot({
    df_2 <- air_quality %>%
      filter(Geo.Place.Name == input$location) %>%
      separate(Time.Period, into = c("time", "year"), sep = "(?<=\\D)(?=\\d)", extra = "merge") %>%
      mutate(year = as.numeric(trimws(year)), time = trimws(time)) %>%
      filter(time == "Annual Average") %>%
      arrange(year)
    
    df_aggregated <- df_2 %>%
      group_by(year, Name) %>%
      summarise(AvgDataValue = mean(Data.Value, na.rm = TRUE)) %>%
      ungroup()
    
    df_wide <- df_aggregated %>%
      select(year, Name, AvgDataValue) %>%
      spread(Name, AvgDataValue) %>%
      mutate(x = `Fine particles (PM 2.5)`, y = `Nitrogen dioxide (NO2)`)
    
    correlationPlot <- ggplot(data = df_wide, aes(x = x, y = y)) +
      geom_point() +
      labs(title = paste("Correlation between PM2.5 and NO2 Levels in", input$location,"across\
                         years (2009-2021)"),
           x = "Value for PM2.5 [mcg/m3]",
           y = "Value for NO2 [ppb]") +
      theme_minimal() +
      theme(axis.text.x = element_text(vjust = 0.5, hjust = 0.5, size = 13),
            axis.title.x = element_text(vjust = 0.5, hjust = 0.5, size = 15),
            axis.text.y = element_text(vjust = 0.5, hjust = 0.5, size = 13),
            axis.title.y = element_text(vjust = 0.5, hjust = 0.5, size = 15),
            plot.title = element_text(size = 20, hjust = 0.3),
            plot.caption = element_text(size = 9))
    
    if(input$linear){ 
      correlationPlot <- correlationPlot + geom_smooth(method = "lm", color = "blue") 
    }
    
    print(correlationPlot)
    
  })

}
