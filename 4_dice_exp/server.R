# server
library(shiny)
library(ggplot2)
df <- replicate(100, sample(1:6, 10, repl = TRUE))
tot_m <- mean(df)
df <- as.data.frame(df)
df_m <- colMeans(df)
df_s <- colSums(df)
df_exp <- data.frame(index = 1:100,
     expec = cumsum(df_s) / (seq(1:100) * 10))

theme_set(theme_bw())
shinyServer(function(input, output){

  output$bar <- renderPlot({
  	ggplot(df, aes_string(x = paste0("V", input$roll))) +
  	  geom_bar() + labs(x = "Roll 10 dices") +
  	  lims(x = c("1", "2", "3", "4", "5", "6"), y = c(0, 6))
  })
  
  output$sample_dist <- renderPlot({
  	df_hist <- as.data.frame(df_m[1:input$roll])
  	names(df_hist) <- "X"
  	ggplot(df_hist, aes(x = X)) +
  	  geom_histogram() + labs(x = "Mean of each roll") +
  	  xlim(2, 5) + ylim(0, 40)
  })
  output$expectation <- renderPlot({
  	ggplot(df_exp[1:input$roll,], aes(x = index, y = expec)) +
  	  geom_line() +
  	  geom_hline(yintercept = tot_m, linetype = "dashed") +
  	  xlim(1, 105) + ylim(2, 5)
  })
  
  
})