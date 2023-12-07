
library(shinydashboard)
library(leaflet)
air_quality <- read.csv("Air_Quality.csv")
header <- dashboardHeader(title = "Air quality in NY")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(HTML("Distribution of different air quality <br/> indicators across location types"), tabName = "2"),
    menuItem(HTML("Trend for NO2 and PM2.5 in NY"), tabName = "1"),
    menuItem(HTML("Correlation between NO2 and PM2.5 <br/> across places in NY"), tabName = "3")
  )
  
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "2",
      fluidRow(selectInput("name", "Select indicator", 
                           choices = unique(air_quality$Name)),),
      fluidRow(uiOutput("timeSelectorUI")),
      fluidRow(box(width = 10, plotOutput("trend"))),
      fluidRow(
        box(
          title = "Borough",
          solidHeader = TRUE,
          status = "primary",
          width = 5,
          HTML(paste("<div style='font-size: 12px;'></b> The Boroughs of New York City are the five major governmental districts that compose New York City. The boroughs are the Bronx, Brooklyn, Manhattan, Queens, and Staten Island.</div>"))
        ),
        box(
          title = "CD",
          solidHeader = TRUE,
          status = "primary",
          width = 5,
          HTML(paste("<div style='font-size: 12px;'></b> New York City's 59 community boards were created by local law in 1975, and each represents a community district. </div>"))
        )
      ),
      fluidRow(
        box(
          title = "UHF 42",
          solidHeader = TRUE,
          status = "primary",
          width = 5,
          HTML(paste("<div style='font-size: 12px;'></b> United Hospital Fund (UHF) Neighborhoods (42) consist of 42 adjoining zip code areas, designated to approximate New York City Community Planning Districts.</div>"))
        ),
        box(
          title = "UHF 34",
          solidHeader = TRUE,
          status = "primary",
          width = 5,
          HTML(paste("<div style='font-size: 12px;'></b> United Hospital Fund (UHF) Neighborhoods (34) consist of 34 adjoining zip code areas with similar characteristics.</div>"))
        )
      ),
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
