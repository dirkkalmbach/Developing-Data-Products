library(shiny)

# Define UI for application
shinyUI(fluidPage(
    titlePanel("SimpleInvest"),
    sidebarLayout(
        sidebarPanel(
            helpText("Type in a stock symbol (e.g.: AAPL for Apple) and you see its chart on the right side.  
                    (Information will be collected from yahoo finance.):"),
            textInput("symb", "Symbol", "SPY"),
            helpText("Choose X number of days to see when the stock price increased X number of days in a row:"),
            sliderInput("days",
                        "Days",
                        min = 2,
                        max = 10,
                        value = 9),
            br(),
            br(),
            h4("Documentation:"),
            p("The aim of ",
                strong('SimpleInvest' ),
                " is to show you all times when a stock has been risen 
                for a particular number of days. With this information you can check if the simple 
                investment strategie",
                    span("Buy a stock and sell it the next day if the stock has been risen
                    the last x days", style="color:orange"), "works."),
            
            p("Some possible stock symbols you could try are:"),
            
            
              tags$ul(
                  tags$li("AAPL (=Apple)"), 
                  tags$li("GM (=General Motors)"), 
                  tags$li("WFC (=Wells Fargo)")),
            p("(Look out for more on ", tags$a(href="http://finance.yahoo.com", "Yahoo Finance"),")."),
            p("Then you should choose the number of days. The App prints out a table with all
              events when the stock has been risen for so many days in a row. 
              You can also see how much the stock has been risen during this event."),
            p("But the most important information is the column ",em("Stock increase next day"),". There you
              can see the increase for the next day."),
            p("The last column shows the cummulative increase. E.g.: how much you would have earned,
              if you would have been chosen this investment strategie from 2007 till now.")
        ),
        mainPanel(
            #img(src = "my_logo.png", height = 7, width = 7),
            plotOutput("plot"),
            tableOutput("table"),
            span("NOTE: Due to some formatting problems in shiny the first two rows show the date
                 in numeric values. I apologize.", style="color:red")
        )
    )
    
)
)

