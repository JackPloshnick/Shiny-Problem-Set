# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Presidential..."),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("Campbell", "Lewis-Beck", "EWT2C2", "Fair",  "Abramowitz" )),
      
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
  
  datasetInput <- reactive({
    switch(input$dataset,
           "Campbell" = presidentialForecast[15: (16- input$obs),]$Campbell,
           "Lewis-Beck" =presidentialForecast[15: (16- input$obs),]$`Lewis-Beck`,
           "EWT2C2" =presidentialForecast[15: (16- input$obs),]$EWT2C2,
           "Fair" =presidentialForecast[15: (16- input$obs),]$Fair,
           "Hibbs" =presidentialForecast[15: (16- input$obs),]$Hibbs,
           "Abramowitz" =presidentialForecast[15: (16- input$obs),]$Abramowitz )
  })
  
  output$view <- renderTable({
    tail(presidentialForecast , n = input$obs )
  })
  
  output$distPlot <- renderPlot({
   
    hist(presidentialForecast[15: (16- input$obs),]$Actual, col=rgb(1,0,0,alpha=0.5), xlim = c(40,60))
    hist(datasetInput(),  col=rgb(0,0,1,alpha=0.5), add=T )
     
  })
}


shinyApp(ui,server)

install.packages("EBMAforecast")
library("EBMAforecast")
data("presidentialForecast")

hist(presidentialForecast$Actual)

presidentialForecast[1:2,]$Actual
