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
           "Campbell" = presidentialForecast$Campbell,
           "Lewis-Beck" =presidentialForecast$`Lewis-Beck`,
           "EWT2C2" =presidentialForecast$EWT2C2,
           "Fair" =presidentialForecast$Fair,
           "Hibbs" =presidentialForecast$Hibbs,
           "Abramowitz" =presidentialForecast$Abramowitz )
  })
  
  output$view <- renderTable({
    tail(presidentialForecast , n = input$obs )
  })
  
  output$distPlot <- renderPlot({
   
    hist(presidentialForecast$Actual)
    hist(datasetInput(),  col=rgb(0,0,1,alpha=0.3), add=T )
     
  })
}


shinyApp(ui,server)

install.packages("EBMAforecast")
library("EBMAforecast")
data("presidentialForecast")

nrow(presidentialForecast)

dev.off
x= c(1,1,1,2,2,3)
y= c(2,2,3,3)
hist(x, col = "Red")
hist(y, add = T)
