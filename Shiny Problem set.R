# Define UI for dataset viewer app ----
library("EBMAforecast")
data("presidentialForecast")


ui <- fluidPage(
  
  plotOutput("distPlot", click = "plot_click"), #creates interactive plot 
  verbatimTextOutput("info"),

  
  # App title ----
  titlePanel("Presidential Model Comparison"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      selectInput(inputId = "dataset",
                  label = "Choose a model",
                  choices = c("Campbell", "Lewis-Beck", "EWT2C2", "Fair",  "Abramowitz" )),
      
      numericInput(inputId = "obs",
                   label = "Choose how many elections you want to see",
                   value = 15, max = 15, min = 1)
    ,
      
      # Include clarifying text ----
      helpText("Click on the model you want to compare to the actual election result.
               Mostr recent election shown first")
      
 
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
     
      tableOutput("view")
      
      
    
    
    )
    
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  library("EBMAforecast")
  
  datasetInput <- reactive({ #drop down menu of models 
    switch(input$dataset,
           "Campbell" = presidentialForecast[15: (16- input$obs),]$Campbell,
           "Lewis-Beck" =presidentialForecast[15: (16- input$obs),]$`Lewis-Beck`,
           "EWT2C2" =presidentialForecast[15: (16- input$obs),]$EWT2C2,
           "Fair" =presidentialForecast[15: (16- input$obs),]$Fair,
           "Hibbs" =presidentialForecast[15: (16- input$obs),]$Hibbs,
           "Abramowitz" =presidentialForecast[15: (16- input$obs),]$Abramowitz )
  })
  
  output$view <- renderTable({ #prints table 
    tail(presidentialForecast , n = input$obs )
  })
  
  output$distPlot <- renderPlot({
   
    hist(presidentialForecast[15: (16- input$obs),]$Actual, col=rgb(1,0,0,alpha=0.5), xlim = c(40,65), #plot of actual results 
         main= "Comparing election models to actual election results", xlab = "Predicted Result")
    hist(datasetInput(),  col=rgb(0,0,1,alpha=0.5), add=T) #plot of model 
    legend( "topright", legend= c("model", "actual", "overlap"), col= c("blue", "red", "purple" ),
            lty= 1, cex=0.8) 
     
  })
  
  output$info <- renderText({
    paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
  })
}


shinyApp(ui,server)


library("EBMAforecast")
data("presidentialForecast")



