library("shiny")
library("ggplot2")
#https://gitlab.com/snippets/16220
source("tw_example.R")

shinyServer(function(input, output){
  
  output$map <- renderPlot({
    ggplot(wrld, aes(x = long, y = lat, group = group,
           fill = balance, alpha = 0.6)) +
      geom_polygon() +
      scale_fill_manual(values = c("gray90", "firebrick", "forestgreen")) +
      theme_bw() + theme(legend.position = c(0.1, 0.25),
                         legend.title = element_blank())
  })
  
  output$hover_info <- renderUI({
  	hover <- input$plot_hover
  	point <- nearPoints(wrld, hover, threshold = 5, maxpoints = 1, addDist = TRUE)
    if (nrow(point) == 0) return(NULL)
    
    # calculate point position INSIDE the image as percent of total dimensions
    # from left (horizontal) and from top (vertical)
    left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
    top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
    
    # calculate distance from left and bottom side of the picture in pixels
    left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
    top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
    
    # create style property fot tooltip
    # background color is set so tooltip is a bit transparent
    # z-index is set so we are sure are tooltip will be on top
    style <- paste0("position:absolute;z-index:100;background-color:rgba(245, 245, 245, 0.85); ",
                    "left:", left_px + 2, "px; top:", top_px + 2, "px;")
    
    # actual tooltip created as wellPanel
    wellPanel(
      style = style,
      p(HTML(paste0("<b> Country: </b>", point$region, "<br/>",
                    "<b> Balance: </b>", point$balance, "<br/>",
                    "<b> Amount: </b>", abs(point$USD), "<b> 1000 USD</b>", "<br/>")))
#                    "<b> Distance from left: </b>", left_px, "<b>, from top: </b>", top_px)))
    )
  })
})