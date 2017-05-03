library(shiny)
library(shinyjs)
source("./materials.R")
source("./savehtml.R")

user_response <- NULL
#response_time <- NULL

server <- shinyServer(function(input, output, session) {

  # 1. enter infomation
  observe({
    if (is.null(input$name) || input$name == "" ||
        is.null(input$age) ||
        is.null(input$gender) || input$gender == "") {
      shinyjs::disable("submit")
    } else {
      shinyjs::enable("submit")
    }
    # if submit info, hide section 1
    if(input$submit) {
      hideElement(id = "info")
    }
  })

  # 2. instructions
  observe({
    if (input$submit == 0) {
      disable("start_b1")
    } else {
      enable("start_b1")
    }
    if (input$start_b1) {
      hide(id = "instruction")
    }
  })
  
  # 3. Block 1: display stimulus
  # This section makes capitals run as a animation
  imgurl <- reactive({
    i <- input$b1_slider
    return(paste0("./images/stimulus", i, ".png"))
  })
  
  output$stimulus <- renderImage({
    list(src = imgurl(),
         contentType = 'image/png',
         width = 500,
         height = 500)
  }, deleteFile = FALSE)
  
  observe({
    if (input$b1_slider != 80) {
      shinyjs::disable(id = "b2_recog")
    } else {
      shinyjs::enable(id = "b2_recog")
      shinyjs::hide(id = "b1_display")
    }
  })
  
  # 4. Block 2: recognition test
  i <- 0
  observe({
    if (input$b1_slider == 80) {
      user_response <- c(user_response, input$key)
      i <<- i + 1
      urls <- paste0("./images/recog", i, ".png")
      output$recog <- renderImage({
        list(src = urls,
             content = 'image/png',
             width = 500,
             height = 500)
      }, deleteFile = FALSE)

      #t0 <- proc.time()
      user_response <<- c(user_response, input$key)
      #t1 <- proc.time()
      #response_time <<- c(response_time, (t1 - t0)[3])
    }
  })

  observeEvent(input$save, {
    # 80: P, 81: Q, 32: Spacebar
    print(df)
    print(user_response)
  })
})