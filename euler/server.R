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

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  observeEvent(input$run, {
    
    
   
      output$topPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
      withProgress(message = 'Making Chart 1', value = 0, {  
        incProgress(.1)
        
         
        
        df <- data.frame()
        
        df <- na.omit(tq_get(isolate(input$ticker),
                             from = isolate(input$dateStart),
                             to = isolate(input$dateEnd), get="stock.prices") )
        
        df = subset(df, select = -c(symbol,open,high,low,volume,adjusted) )
        
        names(df) <- c('ds', 'y')
        
        incProgress(.3)
        
        m <- prophet(df)
        
        future <- make_future_dataframe(m, periods = isolate(input$sliderForecast))
        
        forecast <- predict(m, future)
        
        incProgress(.6)
       
        plot(m, forecast)  
        
        
          
      })
        
      })
     
      
      output$middlePlot <- renderPlot({  
        
        withProgress(message = 'Making Chart 2', value = 0, {  
          incProgress(.1)
        
        
        df <- data.frame()
        
        df <- na.omit(tq_get(isolate(input$ticker),
                             from = isolate(input$dateStart),
                             to = isolate(input$dateEnd), get="stock.prices") )
        
        df = subset(df, select = -c(symbol,open,high,low,volume,adjusted) )
        incProgress(.3)
        names(df) <- c('ds', 'y')
        
        m <- prophet(df)
        
        incProgress(.4)
        
        future <- make_future_dataframe(m, isolate(input$sliderForecast))
        
        forecast <- predict(m, future)
        
        tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])
        incProgress(.6)
        
        prophet_plot_components(m, forecast)
        
        incProgress(.9)
        
      })
      
      })
    
       
  
  
 
  })
  
  observeEvent(input$topPolot_dblclick, {
    brush <- input$topPlot_brush
    if (!is.null(brush)) {
      ranges$x <- c(brush$xmin, brush$xmax)
      ranges$y <- c(brush$ymin, brush$ymax)
      
    } else {
      ranges$x <- NULL
      ranges$y <- NULL
    }
  })
  
 
  

   
}
