library(shiny)
library(shinyjs)

shinyUI(fluidPage(
  useShinyjs(),
  h3("Hot-Hand: 04162017, playoff 1 (OKCHOU), James Harden"),
  sidebarPanel(
    radioButtons("shot",
                label = "Choose Harden made or not made the next 
                        field goal attempt",
                choices = list("Made" = "made",
                               "Not made" = "missed")),
    h4("Submit"),
    actionButton("submit", "If you are ready, press the button.")
  ),
  mainPanel(
    textOutput("result"),
    br(),
    br(),
    DT::dataTableOutput("dtable")
  )
))