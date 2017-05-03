library("shiny")

shinyUI(fluidPage(
  headerPanel("Export and import of Foreign trade of Taiwan (2015) "),
  mainPanel(
    div(
      style = "position:relative",
      plotOutput("map",
                 hover = hoverOpts("plot_hover", delay = 100,
                                   delayType = "debounce")),
      uiOutput("hover_info")
    )
  )
))



