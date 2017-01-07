shinyServer(function(input, output) {
  output$output_prediction<-renderText(paste0("It must be ",predict_func(input$userInput)))
  output$wcloud<-renderPlot({wcloud(predict_func(input$userInput))})
  output$avgnoing<-renderGvis({avg_no_ing_plot})
 }
)