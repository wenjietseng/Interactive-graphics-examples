library(shiny)
dta <- read.table("harden.txt", h = T)
your_guess <- NULL

shinyServer(function(input, output){
   observe({
   	 if (input$submit > 39) {
   	   hideElement(id = "submit")
   	 }
   })

  output$result <- renderText({
  	if (input$submit == 0) {
  	  "James Harden got an 41.7 FG% in 16/17 season.
  	   Will he make the first shot tonight?"
  	} else if (input$submit > 39){
  	tb <- table(your_guess, dta$type) 
  	fg <- (tb[1] + tb[2]) / (tb[1] + tb[2] + tb[3] + tb[4])
    ff <- tb[5] / (tb[5] + tb[6])
  	  paste0("This is the end of the example.
  	  James Harden got 46.4 FG%, 72.7 FT%.\n
  	  Your guessing results are ", round(fg,1) * 100,
  	  " FG%, ", round(ff,1) * 100, " FT%.")
  } else {
  	paste0("He attempted a ", dta$type[input$submit + 1], " 
  	       next, do you think he made it?")
  }
  })
  
  observeEvent(input$submit, {
  	your_guess <<- c(your_guess, input$shot)
  })
  
  observe({
    if (input$submit == 0) return()
    else {
      output$dtable <- DT::renderDataTable({
  	    dta <- data.frame(dta[1:input$submit, ], your_guess)
  	    DT::datatable(dta)
  	  })
    }
  })
})