# export and import data
tw <- read.table("tw_export_import.csv",
                 sep = ',', header = FALSE, stringsAsFactor = FALSE)
# unit: 1000 USD

tw[, -1] <- lapply(tw[, -1], function(lst) {
  as.numeric(
    unlist(
      lapply(
        strsplit(lst, ','), function(x) paste0(x, collapse = "")
      )
    )
  )
})
tw <- data.frame(
  matrix(unlist(strsplit(tw$V1, 'M')), 192, 2, byrow = TRUE),
  tw[, -1])

EI <- rep(c("_E", "_I"), 33)
Country <- rep(c("Total",
      "Asia", "HK", "ID", "JP", "KR", "CN", "MY", "SG", "THA", "VEN",
      "Nahost", "KW", "SB",
      "EU", "FR", "DE", "IT", "EN", "Africa", "NG",
      "NAmerica", "CA", "US",
      "MAmerica", "MX", "PA",
      "SAmerica", "AR", "BR",
      "Oceania", "AU", "NZ"), each = 2)
names(tw) <- c("Year", "Month", paste0(Country, EI))

# tw reshape + map + static
library(reshape2)
tw_long <- reshape(tw, varying = names(tw)[3:68],
                   v.names = 'USD', times = names(tw)[3:68],
                   direction = "long")
tmp <- matrix(unlist(strsplit(tw_long$time, "_")),
              12672, 2, byrow = TRUE)
tw_new <- data.frame(tw_long[, c(1, 2, 4)], tmp)
names(tw_new)[4:5] <- c("Country", "Type")

# group by Year and Country
library(dplyr)
tw_year <- tw_new %>%
  group_by(Year, Country, Type) %>%
  summarise(Sum_of_Year = sum(USD))
tw_year <- as.data.frame(tw_year)

levels(tw_year$Country) <- c("Africa", "Argentina", "Asia",
  "Australia", "Brazil", "Canada", "China", "Germany", "UK",
  "Europe", "France", "Hong Kong", "Indonesia", "Italy", "Japan",
  "South Korea", "Kuwait", "MAmerica", "Mexico", "Malaysia",
  "Nahost", "NAmerica", "Nigeria", "New Zealand", "Oceania",
  "Panama", "SAmerica", "Saudi Arabia", "Singapore", "Thailand",
  "Total", "USA", "Vietnam")
levels(tw_year$Type) <- c("Export", "Import")

#
tmp <- tw_year %>%
subset(Year == 2015) %>%
subset(Country != "Africa") %>%
subset(Country != "Asia") %>%
subset(Country != "Europe") %>%
subset(Country != "Hong Kong") %>%
subset(Country != "Nahost") %>%
subset(Country != "MAmerica") %>%
subset(Country != "NAmerica") %>%
subset(Country != "SAmerica") %>%
subset(Country != "Oceania") %>%
subset(Country != "Total")

#
export <- subset(tmp, Type == "Export")
import <- subset(tmp, Type == "Import")
Diff_of_Year <- export$Sum_of_Year - import$Sum_of_Year
Type <- ifelse(Diff_of_Year > 0, "export > import", "import > export")
tw_2015 <- data.frame(export[, 1:2], Diff_of_Year, Type)

#
library(ggplot2)
wrld <- map_data(map = "world")
wrld$cc <- rep("0", 99338)

USD <- vapply(wrld$regi, function(x) {
  if(x %in% as.character(tw_2015$Country)) {
  	tw_2015[which(tw_2015$Country == x), 'Diff_of_Year']
  } else {0}
}, numeric(1))

wrld$USD <- USD
wrld$balance <- ifelse(wrld$USD == 0, "",
  ifelse(wrld$USD < 0, "Surplus", "Deficit"))
#wrld$USD[which(wrld$USD == 0)] <- NA
wrld$USD2 <- ifelse(wrld$USD < 0, -1,
 ifelse(wrld == 0, 0, 1))

# ggplot
#ggplot(wrld, aes(x = long, y = lat, group = group,
#       fill = USD)) +
#  geom_polygon() +
#  scale_fill_gradient(low = "pink", high = "steelblue",
#                      na.value = "gray90") +
#  theme_bw() + theme(legend.position = c(0.1, 0.25))
