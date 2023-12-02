
library(shinydashboard)
library(leaflet)
air_quality <- read.csv("Air_Quality.csv")
header <- dashboardHeader(title = "Air quality")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Distribution of different air quality indicators across location types",tabName = "2"),
    menuItem("trend for NO2 and PM2.5 in NY",tabName = "1"),
    menuItem("correlation between NO2 and PM2.5 across place in NY",tabName = "3")
    
    
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "2",
      fluidRow(selectInput("name", "Select indicator", 
                           choices = unique(air_quality$Name)),),
      fluidRow(uiOutput("timeSelectorUI")),
      fluidRow(box(width = 12, plotOutput("trend")))
    ),
    tabItem(
      tabName = "1",
      fluidRow(selectInput("indicator", "Select an Indicator:",
                           choices = c("Nitrogen dioxide (NO2)", "Fine particles (PM 2.5)")),
      fluidRow(box(width = 12, plotOutput("time_series")))
    )
  ),
  tabItem(
    tabName = "3",
    fluidRow(selectInput("location", "Select a Location:",
                         choices = unique(air_quality$Geo.Place.Name))),
    fluidRow(checkboxInput("linear", label = "Add trend line?", value = FALSE)),
    fluidRow(box(width = 12, plotOutput("coorelation")))
  )
  
  
))

dashboardPage(header, sidebar, body)
