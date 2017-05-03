# ui
library(shiny)

shinyUI(fluidPage(
  h3("Rolling dice"),
  actionButton("roll", label = "Roll the dice!"),
#  actionButton("reset", label = "Reset"),
  fluidRow(
    column(4, plotOutput("bar")),
    column(4, plotOutput("sample_dist")),
    column(4, plotOutput("expectation")))
))