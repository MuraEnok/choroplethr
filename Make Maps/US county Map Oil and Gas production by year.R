# map of oil and gas by year
library(choroplethr)

gas <- read.csv("data/oil/oilgascounty.csv",  header=TRUE, as.is=TRUE)
title = paste(gas[1, 9:35 ])
title.map = paste(gas[1, "oil2011"])
title.map = gsub('for the year specified in the variable name', "2011", title.map)
gas = gas[-1, c("FIPS", "oil2011", "Stabr" )]
names(gas) = c("region", "value")

gas$region <- as.numeric(gas$region)
# remove the comma from the text string so it can be made into proper numeric
gas$value <- as.numeric(gsub(",", "", gas$value))

choroplethr(gas, lod="county", num_buckets=8, title = title.map, states= western_states)

# gas$r <- as.numeric(cut(gas$region, breaks=8, include.lowest=TRUE))
# gas <- subset(gas,  (gas$Stabr %in% western_states))
# western_states = c("WA", "OR", "ID", "MT", "WY", "SD", "ND")
