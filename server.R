library(quantmod)
library(zoo)


shinyServer(function(input, output) {
    #input$SubmitButton
    output$plot <- renderPlot({
        
        data <- getSymbols(input$symb, src = "yahoo", auto.assign = FALSE)
        plot(data[,4],main=colnames(data[,4])) 
        
    })
    
    
    output$table <- renderTable({
        data <- getSymbols(input$symb, src = "yahoo", auto.assign = FALSE)
        df<-as.data.frame(data[,4])
        
        
        for (i in 2:nrow(df)){
            ifelse( (df[i,1]>df[i-1,1]) , df[i,2]<-"up" , df[i,2]<-"down" )
        }
        temp<-df
        days<-input$days
        indices<-( which(rollapply(temp[,2], days, identical, rep(c("up"),each=days))) )+days-1
        # Initialize empty dataframe:
        summary <- data.frame(From=as.Date(character()),
                                To=as.Date(character()),
                                days=double(),
                                Kursbewegung=double(),
                                GewinnNextDay=double())
        
        for (i in 1:length(indices)) {
            
            summary[i,1]<- rownames(df[indices[i]-days,]) #From
            summary[i,2]<- rownames(df[indices[i],]) #To
            summary[i,3]<- days
            summary[i,4]<- round ( (df[indices[i],1] - df[indices[i]-days,1]) / df[indices[i]-days,1]*100, digits=2 ) #(To-From)/From*100
            summary[i,5]<- round ( (df[indices[i]+1,1] - df[indices[i],1]) / df[indices[i],1]*100, digits=2 ) #(Next-To)/To*100    
            #summary[i,5]<- round ( sum(summary[,4]) )
            summary <- within(summary, SumOfEarning <- cumsum(GewinnNextDay))
        }
        colnames(summary)<-c(
            "From (Date)", "To (Date)", "Number of days", "Stock increase during this time (in %)", "Stock increase next day (in %)", "Cummulative stock increase (in %)")
        #sum<-sum(summary[i,4])
        #summary[i,1]<-as.character(as.Date(summary[i,1]))
        summary
    })   

    output$sum <- renderText({typeof(summary[i,i])})
})
