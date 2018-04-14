# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Presidential..."),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      numericInput(inputId = "obs",
                   label = "Number of elections to view:",
                   value = 15, max = 15)
    ,
      
      # Include clarifying text ----
      helpText("Presidential...")
      
 
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      plotOutput("distPlot"),
      tableOutput("view")
      
      # Output: Header + summary of distribution ----
    
    )
    
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  library("EBMAforecast")
  
  output$view <- renderTable({
    head(presidentialForecast , n = input$obs )
  })
  
  output$distPlot <- renderPlot({
    hist(presidentialForecast$Actual)
  })
  
}

shinyApp(ui,server)

install.packages("EBMAforecast")
library("EBMAforecast")
data("presidentialForecast")

nrow(presidentialForecast)
