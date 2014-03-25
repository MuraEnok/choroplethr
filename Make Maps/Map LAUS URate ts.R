library(choroplethr)
# load the map of laus data to create time series map
load("~/Data/BLS/laus.rda")

system.time(cnty <- subset(laus, year == 2013))

# cnty$type <- substr(cnty$series_id, 19, 20)
# get the unemployment rate
system.time(cnty <- subset(cnty, substr(cnty$series_id, 19, 20) =="03"))

cnty <- subset(cnty, substr(series_id, 1, 5)=="LAUCN")
# create 5 digit fips codes
cnty$region <- as.numeric(substr(cnty$series_id, 6, 10))
cnty$value <- as.numeric(cnty$value)

# remove footnote codes
cnty$footnote_codes <- cnty$series_id <- cnty$year <- NULL

mon <- c(paste(unique(cnty$period)))[-13]
ui = list()
for (i in 1:length(mon)){
  df =  subset(cnty, period == mon[[i]])
  title = paste0("Unemployment by County 2013 ", mon[i])
  ui[[i]] = choroplethr(df, "county", title=title)
}
choroplethr_animate(ui)









# create a list of choropleths of presidential election results for each year
choropleths = list()
for (i in 2:ncol(df_president_ts)) {
  df           = df_president_ts[, c(1, i)]
  colnames(df) = c("region", "value")
  title        = paste0("Presidential Election Results: ", colnames(df_president_ts)[i])
  choropleths[[i-1]] = choroplethr(df, "state", title=title, showLabels=FALSE)
}

# set working directory and animate
# setwd("~/Desktop")
choroplethr_animate(choropleths)

## End(Not run)