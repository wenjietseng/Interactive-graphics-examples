library(ggvis)
library(magrittr) # %>%
library(dplyr)

dta <- read.table("hs0.txt", sep = "", header = TRUE)
str(dta)
names(dta)[2] <- c("gender")

# ~variable_name just like dta$X
p <- ggvis(data = dta, x = ~math, y = ~science)
layer_points(p)

#
ggvis(data = dta, x = ~math, y = ~science) %>%
  layer_points() %>%
  add_axis("x", title = "Math") %>%
  add_axis("y", title = "Science")
  
#
ggvis(data = dta, x = ~math, y = ~science, fill = ~ses) %>%
  layer_points() %>%
  add_axis("x", title = "Math") %>%
  add_axis("y", title = "Science")
  
#
dta$ses <- factor(dta$ses, levels = c("low", "middle", "high"))

ggvis(data = dta, x = ~math, y = ~science, fill = ~ses) %>%
  scale_ordinal("fill", range = c("lightblue","steelblue","blue")) %>%
  layer_points() %>%
  add_axis("x", title = "Math") %>%
  add_axis("y", title = "Science")

ggvis(data = dta, x = ~math, y = ~science,
       stroke = ~ses) %>%
  scale_ordinal("fill", range = c("lightblue","steelblue","blue")) %>%
  layer_points() %>%
  add_axis("x", title = "Math") %>%
  add_axis("y", title = "Science")
  
ggvis(data = dta, x = ~math, y = ~science, fill = ~read) %>%
  scale_numeric("fill", range = c("pink","blue")) %>%
  layer_points() %>%
  add_axis("x", title = "Math") %>%
  add_axis("y", title = "Science")

# interactivity
p <- ggvis(data = dta, x = ~math, y = ~science,
      fill = ~read, opacity := 0.5) %>%
  scale_numeric("fill", range = c("pink","blue")) %>%
  layer_points() %>%
  add_axis("x", title = "Math") %>%
  add_axis("y", title = "Science")

# add new layer
p %>% layer_model_predictions(model = "lm")
p %>% layer_smooths()

# add_tooltip
p %>% add_tooltip(function(dta) dta$read)

# input_select
ggvis(dta, ~read, ~math, opacity := 0.6) %>%
  layer_points(
    fill = input_select(
      choices = c("Gender" = "gender",
                  "Race" = "race",
                  "Social Economic Status" = "ses",
                  "School Type" = "schtyp",
                  "Program" = "prog"),
      label = "Fill by",
      selected = "gender",
      map = as.name))