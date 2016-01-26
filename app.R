#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("mymap", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
    dateRangeInput(inputId = "map_date", label = "Choose a date range" , 
                   start = "2013-01-01",
                   end = Sys.Date())
  )
)

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
   
  output$mymap <- renderLeaflet({
    m <- plotLines(data2 = data2,stations = stations,date_start = input$map_date[1],date_end = input$map_date[2])
    m
  })
})

# Run the application 
shinyApp(ui = ui, server = server)

