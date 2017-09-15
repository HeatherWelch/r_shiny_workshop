##### Shiny application to plot histograms for bycatch data columns
# This is a Shiny web application. You can run the application by clicking -->Run in the upper right of the rstudio console


# ---------------------------------------------------------------------------------------------
# 1. load all your libraries.
library(shiny)
library(rsconnect)
# ---------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------
# 2. load all your data.
dataset=read.csv("data/bycatch_data.csv")
# ---------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------
# 3. UI{}: User Interface. This code block defines app layout and inputs.
ui <-shinyUI(fluidPage(
  selectInput(inputId = "column",
              label = "DataFrame column",
              choices = c("TOTAL.FISHERY.BYCATCH","TOTAL.FISHERY.LANDINGS","FISHERY.BYCATCH.RATIO")),
  
  plotOutput(outputId = "main_plot")
))
# ---------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------
# 4. Server(): This code block defines what to do with inputs. This is the workhorse of your app.
server <- shinyServer(function(input, output) {
  
  output$main_plot <- renderPlot({
    col=input$column
    index=as.numeric(grep(col,colnames(dataset)))
    hist(dataset[[index]],
         xlab = col,
         main = paste0("Histogram of ",col))
  })
  
})
# ---------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------
# 5. Run the application
shinyApp(ui = ui, server = server)
# ---------------------------------------------------------------------------------------------

#rsconnect::deployApp()