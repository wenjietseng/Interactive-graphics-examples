library(shiny)
library(shinyjs)
library(animation)
dta <- read.table("./materials.txt", h = FALSE)
dta
display_block <- sample(1:40, 40)
recog_block <- sample(c(sample(1:40, 20), 41:60), 40)
df <- data.frame(dta[display_block,], dta[recog_block,])
names(df) <- c("display", "recog")
df$ans <- as.numeric(df$recog %in% df$display)

df
# -information of participant
# -instruction
# -display 40 capitals
# -recognition, pressing keyboard 
#  record response and reaction time
# -end of experiment

# One trial
# attention fixed point
#par(bg = "black")
#plot(0, 0)
#text(0, 0, "+", col = "white", cex = 4)
#text(0, 0, "+", col = "black", cex = 5)

# stimulus
#text(0, 0, "capital", col = "white", cex = 4)

#
#par(bg = "black")
#oopt <- ani.options(nmax = 40)
#for (i in 1:ani.options("nmax")) {
#  # attention fixed point
#  plot(0, 0, type = "n")
#  text(0, 0, "+", col = "white", cex = 4)
#  Sys.sleep(.25)
#  plot(0, 0)
#  text(0, 0, df$display[i], col = "white", cex = 4)
#  Sys.sleep(1)
#}
#dev.off()
