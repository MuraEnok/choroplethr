library(devtools)
install_github("choroplethr", "trulia")
library(choroplethr)

# download from https://www.bea.gov/regional/downloadzip.cfm a file in 
# the Local Area Personal Income accounts called CA91: gross commuters' earnings flows
unzip("data/BEA/CA91.zip")

c <- read.table("df.txt")
# get bear facts files into a datatable for all counties
# https://www.bea.gov/regional/downloadzip.cfm
loc = dir("CA91/", pattern=".csv")

# get all the BEA local files and put into a directory called data 2 choices CA04 and CA91
base <- "CA91/" 
files <- lapply(loc, function(.state){ 
  cat(.state, "\n") 
  input <- read.csv(paste0(base, .state)
                      , sep=","
                      , header=FALSE
                      , as.is=TRUE
                      , skip=1
  )
  
  
  input
})
# this creates the data table for the set
df <- do.call(rbind, files)


# get the names of the files 
x <- names(read.csv(paste0(base, loc[3]), sep=",", header=TRUE, as.is=TRUE))
names(df) <- x
# remove the files to keep memory clean
rm(x)
rm(files)
# set function to clean up space issue with text descriptions
trim.leading <- function (x)  sub("^\\s+", "", x)
df$LineTitle <- trim.leading(df$LineTitle)


# subset dataset based on year and category

df <- subset(df, LineTitle == "Residence adjustment"  )[, c("FIPS", "X2012" )]

df$region <- as.numeric(df$FIPS)
df$value <-  as.numeric(df[,2])
df <- df[,3:4]
# write.csv(df, "df.csv")

# subset for a region
inland_nw = c("WA", "OR", "ID", "MT", "WY")
#this creates map
choroplethr(df, "county", states= inland_nw, num_buckets=8)

