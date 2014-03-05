# map of oil and gas by year
library(choroplethr)

gas <- read.csv("/Users/ak/Dev/r/choroplethr/data/oil/oilgascounty.csv",  header=TRUE, as.is=TRUE)
title = paste(gas[1, ])
title = paste(gas[1, "gas2011"])
gas = gas[-1, c("FIPS", "oil2011")]
names(gas) = c("region", "value")
gas$region <- as.numeric(gas$region)


gas$value <- as.numeric(gsub(",", "", gas$value))
gas$r <- as.numeric(cut(gas$region, breaks=8, include.lowest=TRUE))

choroplethr(gas, lod="county", num_buckets=8)

str(gas)