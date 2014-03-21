# Code to replicate bug for choroplethr package title printing issue
# get data source

library(choroplethr)
# df <- paste df.txt here

choroplethr(df, "county", title= "this is a test", num_buckets=8)