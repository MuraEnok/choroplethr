# library(devtools)
# install_github("choroplethr", "trulia")
# running version 1.2

library(choroplethr)
library(foreign)
library(gridExtra)
library(ggplot2)
# get the data for the 2010 religious census for US. as a stata file and use foreign to read as data.frame
#http://www.thearda.com/download/download.aspx?file=U.S.%20Religion%20Cens
#url = "http://www.thearda.com/download/download.aspx?file=U.S.%20Religion%20Census%20Religious%20Congregations%20and%20Membership%20Study,%202010%20(County%20File).DTA"
#relig <- read.dta(url)

# the web link is broken so uploaded the file as a csv to data file
relig <- read.csv("data/religious_census.csv", header=TRUE, sep=",", as.is=TRUE)
# this data grabs the total count for orthodox church definitions found in religion.TXT
# orthodox <- c(16, 17, 18, 562, 563, 564, 565, 566, 567, 568)
orthodox <- c(17, 563, 565)
catholic <- c(14, 563, 565)

#trim the data to exclude Hawai and Alaska
relig <- subset(relig, !(relig$stabbr %in% c("AK", "HI")))

#print the Orthodox map
reli.o <- relig[, orthodox]
names(reli.o)[1] = "count"
reli.o$value <- as.numeric(cut(reli.o$count, c(0, 1, 2, 5, 10, 20, 50)))
reli.o = reli.o[, c(2, 4)]
names(reli.o)[1] = "region"
choroplethr(reli.o, lod="county", num_buckets=8)

# print the Catholic map
reli.c <- relig[, catholic]
names(reli.c)[1] = "count"
reli.c$value <- as.numeric(cut(reli.c$count, c(0, 1, 2, 5, 10, 20, 50)))
reli.c = reli.c[, c(2, 4)]
names(reli.c)[1] = "region"
choroplethr(reli.c, lod="county", num_buckets=8)

# make the call to the choroplethr function and easy map
# do a grid view of both maps side to side
orth_map = choroplethr(reli.o, lod="county", num_buckets=8)
cath_map = choroplethr(reli.c, lod="county", num_buckets=8)

grid.arrange(orth_map, cath_map, nrow=1, ncol=2)