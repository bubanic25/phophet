
library(shiny)
library(tidyquant)
library(forecast)
library(ggthemes)
library(forecast)
library(tidyverse)
library(tseries)
library(lubridate)
library(timetk)
library(readxl)
library(tidyquant)
library(scales)
library(forecast)  
library(rlang) #  forecasting pkg
library(sweep)   # Broom tidiers for forecast pkg
library(broom)
library(tibble)
library(stringr)
library(highcharter)
library(knitr)
library(quantmod)
library(shinythemes)
library(ggforce)
library(prophet)

theme_set(theme_bw(10))
initialTicker <- "DOJ"


# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("slate"),

    # Application title
    

    
   
    
    
    
    
    sidebarLayout(
      sidebarPanel(
        
        textInput("ticker", "Ticker", ""),
        dateInput("dateStart", "Start Date of Analysis:", value = "1900-01-21"),
        dateInput("dateEnd", "End Date of Analysis:", value = "2021-05-09"),
       
        sliderInput("sliderForecast", "Number of Days to Forecast", 180, 1000, 180),
  
        
        
       
        
        helpText("Note: At Default Setting this forecasting simulation takes about 2 minutes to execute per Quote.",
                 ),
        
        actionButton("run", "Run")
      ),
      
      
      
      
      
      
      
   
    
    mainPanel(
      
      
      fluidRow(
        column(           
                           width = 10,
               
                 
                 plotOutput("topPlot", dblclick = "topPlot_dblclick",
                            brush = brushOpts(
                              id = "topPlot1_brush",
                              resetOnNew = TRUE)
                
               
                  )
        )
      ),
      
      
      fluidRow(
        column(
               
                 
                 plotOutput("middlePlot"),
                 width = 10
               
                )
      
      
          ),
      
      
      fluidRow(
        column(
          
          
          plotOutput("bottomPlot"),
          width = 10
          
        )
        
        
      )
      
    )
    
    )
      
      
      
      
    
    
 
    
    
    
   
   
    
)
