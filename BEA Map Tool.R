# get bear facts files into a datatable for all counties

loc = dir("/Users/ak/Data/BEA/CA04/")
# remove strange files
loc = loc[- c(1, 7, 9, 11,  13, 15, 25, 28, 32, 46, 52)]


loc
base <- "/Users/ak/Data/BEA/CA04/" 
files <- lapply(loc, function(.state){ 
  cat(.state, "\n") 
  input <- read.csv(paste0(base, .state)
                      , sep=","
                      , header=FALSE
                      , as.is=TRUE
  )
  
  
  input
})
# this creates the data table for the set
CA04 <- do.call(rbind, files)
x <- names(read.csv(paste0(base, loc[1]), sep=",", header=TRUE, as.is=TRUE))
names(CA04) <- x
rm(x)
rm(files)
# subset farm income
income <- subset(CA04, LineTitle == "    Farm income 2/")[, c("FIPS", "X2012")]
income$region <- as.numeric(income$FIPS)
income$value <- as.numeric(income$X2012)

choroplethr(income, "county", title="Farm Income")


