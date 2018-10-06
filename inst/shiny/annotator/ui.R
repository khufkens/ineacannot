require(shiny)
require(shinydashboard)

# Define UI ----
ui <- dashboardPage(
  dashboardHeader(title = "INEACannot"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    tabBox(width = "100%",
    tabPanel("Annotate",
                          fluidRow(
                            column(2, strong("Directory")),
                            column(2, 
                                   textOutput("location")),
                            column(2, strong("Image name")),
                            column(6, 
                                   textOutput("filename"))
                            
                          ),
                          tags$hr(style="border-color: black;"),
                          fluidRow(
                            
                            column(2, 
                                   textInput("station", "Station", 
                                             value = "NA")),
                            column(2, 
                                   textInput("number", "Station number", 
                                             value = "NA")),
                            
                            column(2, 
                                   textInput("lat", "Latitude", 
                                             value = "NA")),
                            column(2, 
                                   textInput("lon", "Longitude", 
                                             value = "NA")),
                            column(2,
                                   selectInput("month", "Month", 
                                               choices = c("NA", month.name))),
                            
                            column(2,
                                   selectInput("year", "Year", 
                                               choices = c("NA", 1900:1960)))
                            
                          ),
                          
                          fluidRow(
                            column(2,
                                   strong("Climate Variables"),
                                   checkboxInput("t_min", "Temp. min", value = FALSE),
                                   checkboxInput("t_max", "Temp. max", value = FALSE),
                                   checkboxInput("precip", "Precip.", value = FALSE),
                                   checkboxInput("precip_intensity", "Precip. intensity", value = FALSE),
                                   checkboxInput("psy_temp_dry", "Psych. dry temp.", value = FALSE),
                                   checkboxInput("psy_temp_humid", "Psych. humid temp.", value = FALSE),
                                   checkboxInput("relative_humidity", "Rel. humdity", value = FALSE),
                                   checkboxInput("evapometre_de_piche", "Evap. de piche", value = FALSE),
                                   checkboxInput("temp_du_bar", "Temp. du bar", value = FALSE),
                                   checkboxInput("haut_bar_luc", "Haut bar. luc.", value = FALSE),
                                   checkboxInput("t1", "T1", value = FALSE),
                                   checkboxInput("t2", "T2", value = FALSE),
                                   checkboxInput("t3", "T3", value = FALSE),
                                   checkboxInput("actino", "Actino", value = FALSE),
                                   checkboxInput("hygro", "Hygro", value = FALSE),
                                   checkboxInput("cloud_type", "Cloud type", value = FALSE),
                                   checkboxInput("nebulosity", "Nebulosity", value = FALSE)
                            ),
                            
                            column(10,
                                   imageOutput("myImage")
                            )
                          ),
                          
                          fluidRow(
                            
                            column(1,
                                   actionButton("back","Back")),
                            
                            column(1,
                                   actionButton("submit", "Submit"))
                            
                          )
                 ),
                 tabPanel("Summary Statistics",
                          
                          fluidRow(
                            column(12,
                            # Dynamic infoBoxes
                            infoBoxOutput("total_images"),
                            infoBoxOutput("progress")
                            )
                          ),
                          fluidRow(
                            column(12,
                            DT::dataTableOutput("table")
                            )
                          )
                          )
  )
  )
)