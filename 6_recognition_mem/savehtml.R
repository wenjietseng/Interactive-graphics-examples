# display
saveHTML({
  oopt <- ani.options(nmax = 40)
  par(bg = "black")
  for (i in 1:ani.options("nmax")) {
    # attention fixed point
    plot(0, 0, type = "n")
    text(0, 0, "+", col = "white", cex = 3)
#    Sys.sleep(.25)
    plot(0, 0)
    text(0, 0, df$display[i], col = "white", cex = 2)
#    Sys.sleep(1)
  }
}, img.name = "stimulus", htmlfile = "stimulus.html",
   ani.height = 500, ani.width = 500)

# recog
saveHTML({
  oopt <- ani.options(nmax = 40)
  par(bg = "black")
  for (i in 1:ani.options("nmax")) {
    # attention fixed point
    plot(0, 0, type = "n")
    text(0, 0, "+", col = "white", cex = 3)
    #    Sys.sleep(.25)
    plot(0, 0)
    text(0, 0, df$recog[i], col = "white", cex = 2)
    #    Sys.sleep(1)
  }
}, img.name = "recog", htmlfile = "recog.html",
ani.height = 500, ani.width = 500)
