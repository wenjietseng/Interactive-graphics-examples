library(shiny)
library(shinyjs)

shinyUI(fluidPage(
  useShinyjs(),
  div(id = "info",
      h3("Please enter your information"),
      textInput("name", "Name", ""),
      numericInput("age","Age",value=NULL,min=18,max=75,step=1),
      textInput("gender", "Gender", ""),
      actionButton("submit", "Submit")
  ),
  
  div(id = "instruction",
      h3("Read the intructions, press 'Start Experiment' when you are
         ready."),
      p("Welcome to Recognition Memory Task! In this task,
        you will watch a series of capitals of countries
        in this block. Try to memorize them as many as possible."),
      actionButton("start_b1", "Start Experiment"),
      br(),
      br()
      ),
  div(id = "b1_display",
      sidebarPanel(
        sliderInput('b1_slider', 'Steps',
                    min = 1, max = 80, value = 1,
               animate = animationOptions(interval = 1000, loop = FALSE))
        ),
      mainPanel(
        imageOutput("stimulus")
      ),
      br(),
      br()
  ),

  div(id = "b2_recog",
    sidebarPanel("Press 'SPACEBAR' to pass the '+' symbol.
                  Press 'Q', if the capital is NOT in the previous list.
                  Press 'P', if the capital is in the previous list."),
    mainPanel(imageOutput("recog")),
    tags$script('
      $(document).on("keydown", function (e) {
        Shiny.onInputChange("key", e.which);
      });
    ')
  ),
  
  actionButton('save', label = "Press me to save the data!")
))