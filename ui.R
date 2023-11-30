
library(shinydashboard)
library(leaflet)
air_quality <- read.csv("Air_Quality.csv")
header <- dashboardHeader(title = "Air quality")

sidebar <- dashboardSidebar(
  sidebarMenu(

    selectInput("name", "Select indicator", 
                choices = unique(air_quality$Name)),
    uiOutput("timeSelectorUI")
#    selectInput("time", "Select time period", 
#                choices = NULL)
  )
)

body <- dashboardBody(
  
  
  #tabItems(
   # tabItem(tabName = "dashboard",
            fluidRow(
              box(width = 12, plotOutput("trend"),
                  )

    )
  #)
#)
)

dashboardPage(header, sidebar, body)
