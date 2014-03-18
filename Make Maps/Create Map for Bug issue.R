# Code to replicate bug for choroplethr package title printing issue
# get data source

library(choroplethr)



df <- read.csv("df.csv", sep=",", header=TRUE, as.is=TRUE)

choroplethr(df, "county", title= title.var, num_buckets=8)