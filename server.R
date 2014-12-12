library(shiny)

shinyServer(function(input, output) {
        
    # output sample size using formula withOUT finite population correction factor (fpc)
    output$sampleSize <- renderPrint({
        
        numerator <- qnorm((input$alpha)/2)^2 * input$p * (1 - input$p)
        denominator <- input$d^2
        round(numerator / denominator, 0)
        
    })
    
    # output sample size using formula with finite population correction factor (fpc)
    output$sampleSizeFpc <- renderPrint({
        
        numerator <- input$N * input$p * (1 - input$p)
        denominator <- ((input$N - 1) * (input$d^2 / qnorm((input$alpha)/2)^2)) + (input$p * (1 - input$p))
        round(numerator / denominator, 0)
        
    })

})