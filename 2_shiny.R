library(shiny)
library(dplyr)
library(magrittr)
library(ggplot2)

##### A plain example with text
# shinyUI
ui.0 <- shinyUI(fluidPage(
  h3("A simple user interface example"),
  sidebarLayout(
    sidebarPanel(
      textInput("text", label = "Just type some texts :)")
    ),
    mainPanel(
      h1(textOutput("out.text"))
    )
  )
))
# shinyServer

server.0 <- shinyServer(function(input, output){
  output$out.text <- renderText({
  	print(input$text)
  })
})

shinyApp(ui.0, server.0)

##### shiny with ggplot and hs0
dta <- read.table("hs0.txt", sep = "", header = TRUE)
names(dta)[2] <- c("gender")
str(dta)
dta$ses <- factor(dta$ses, levels = c("low", "middle", "high"))

# shinyUI
ui.1 <- shinyUI(fluidPage(
  h3("Let's draw ggplot on shinyUI."),
  h4("Select two test scores from five of them,
     could examine by facet_grid or by color"),
  sidebarLayout(
    sidebarPanel(
      selectInput("x", choices = c("Reading" = "read",
                                   "Writing" = "write",
                                   "Mathematics" = "math",
                                   "Science" = "science"),
                  selected = "read",
                  label = "X"),
      selectInput("y", choices = c("Reading" = "read",
                                   "Writing" = "write",
                                   "Mathematics" = "math",
                                   "Science" = "science"),
                  selected = "math",
                  label = "Y"),
      selectInput("v1", choices = c("Gender" = "gender",
                                    "Race" = "race",
                                    "Social economic status" = "ses",
                                    "School type" = "schtyp",
                                    "Program" = "prog",
                                    "None" = "None"),
                  selected = "None",
                  label = "V1 seperate data by facet_grid"),
      selectInput("v2", choices = c("Gender" = "gender",
                                    "Race" = "race",
                                    "Social economic status" = "ses",
                                    "School type" = "schtyp",
                                    "Program" = "prog",
                                    "None" = "None"),
                  selected = "None",
                  label = "V2 seperate data by colors"),
      h5('If V1 and V2 both are selected, plot with facet_grid only.')
    ),
    mainPanel(
      fluidRow(textOutput("warn")),
      fluidRow(plotOutput("out.plot"))
    )
  )
))
# shinyServer

server.1 <- shinyServer(function(input, output){
  output$warn <- renderText({    
  	if(input$x == input$y) {
  	  print("X and Y should be different variables. Please select them correctly.")
  	}
  	if(input$v1 != "None" & input$v2 != "None") {
  	  if(input$v1 == input$v2) {
  	    print("V1 and V2 should not be same. Please select again.")
  	  }
    }
  })
  output$out.plot <- renderPlot({    
  	if(input$x != input$y) {

  	  p <- ggplot(dta, aes_string(x = input$x, y = input$y )) +
  	         geom_point() +
  	         stat_smooth(method = "lm", se = FALSE, lty = 2) +
  	         xlim(20, 80) + ylim(20, 80) + theme_bw()
  	  
      if(input$v1 != "None" & input$v2 != "None") {
  	    p + facet_grid(as.formula(
  	          paste0(input$v2, " ~ ", input$v1)))
      } else if(input$v1 != "None" & input$v2 == "None") {
      	p + facet_grid(as.formula(paste0(". ~ ", input$v1)))
      } else if(input$v1 == "None" & input$v2 != "None") {
      	ggplot(dta, aes_string(x = input$x, y = input$y,
      	       color = input$v2)) +
  	      geom_point() +
  	      stat_smooth(method = "lm", se = FALSE, lty = 2) +
          scale_color_manual(values = 
            c("steelblue", "skyblue", "orchid", "violetred")) +
  	      xlim(20, 80) + ylim(20, 80) + theme_bw() +
  	      theme(legend.position = c(.1, .8))
  	  } else {p}
  	}
  	
  })
})

shinyApp(ui.1, server.1)
