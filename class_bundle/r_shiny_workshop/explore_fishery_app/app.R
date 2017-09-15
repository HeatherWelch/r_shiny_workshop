##### Shiny application to plot bar graphs of the most and least bycatch in each fishery
# This is a Shiny web application. You can run the application by clicking -->Run in the upper right of the rstudio console


# ---------------------------------------------------------------------------------------------
# 1. load all your libraries.
library(shiny)
library(rsconnect)
library(tidyverse)
library(reshape)
# ---------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------
# 2. load all your data.
dataset=read.csv("data/bycatch_data.csv")
fisheries=levels(dataset$FISHERY)
# ---------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------
# 3. UI{}: User Interface. This code block defines app layout and inputs.
ui <-shinyUI(fluidPage(
  selectInput(inputId = "Fisheries",
              label = "DataFrame column",
              choices = fisheries),

  selectInput(inputId = "HL",
              label = "Species with highest or lowest bycatch",
              choices = c("Highest","Lowest")),
  
  plotOutput(outputId = "main_plot")
))
# ---------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------
# 4. Server(): This code block defines what to do with inputs. This is the workhorse of your app.
server <- shinyServer(function(input, output) {
  
  output$main_plot <- renderPlot({
    data=dataset[dataset$FISHERY==input$Fisheries,c(2,7)]%>%melt(.,id="SCIENTIFIC.NAME")%>%.[order(.[,"value"]),]
    
    if(input$HL=="Highest"){
      df=data[c((nrow(data)-10):(nrow(data))),]
    }else{
      df=data[1:10,]
    }
    
    graph=ggplot()+geom_col(data=df,aes(SCIENTIFIC.NAME,value))+labs(y="Pounds")+labs(x="Scientific Name")
    graph
    
  })
  
})
# ---------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------
# 5. Run the application
shinyApp(ui = ui, server = server)
# ---------------------------------------------------------------------------------------------

#setwd("application parent directory")
#rsconnect::deployApp()