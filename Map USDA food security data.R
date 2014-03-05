# Food Insecurity map US counties
library(choroplethr)

# data found http://www.ers.usda.gov/datafiles/Food_Environment_Atlas/Data_Access_and_Documentation_Downloads/Current_Version/DataDownload.xls
# excel file saved as csv files, one for each tab and in data folder
loc = dir("Data/food/")
# [1] "Access.csv"                   [2]"Assistance.csv"               [3]  "Health.csv"                    
# [4] "Insecurity.csv"               [5] "Local.csv"                   [6]   "Prices_taxes.csv"              
# [7] "Restaurants.csv"              [8]  "Socioeconomic.csv"          [9]   "Stores.csv"                    
# [10] "Supplemental Data - County.csv" [11] "Supplemental Data - State.csv"  [12] "Variable_List.csv" 

# choose a number to get the file [ place num here]
file.name = loc[1]
 
base = "Data/food/"
name = paste0(base, file.name, sep="")
file <- read.csv(name, sep=",", as.is=TRUE, header=TRUE)


# place the variable code here
Var.Code = "PCT_LACCESS_LOWI10"

vl = paste0(base, loc[12], sep="")

var.list <- read.csv(vl, sep=",", as.is=TRUE, header=TRUE)                      
var.list = subset(var.list, Category.Code == "ASSISTANCE")

# place the df to map here
df = file
# grab the variable from 
df = df[, c(Var.Code, "FIPS")]
names(df) = c ("value", "region")

choroplethr(df, "county")

