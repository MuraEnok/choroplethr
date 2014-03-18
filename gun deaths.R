
gun.deaths <-  
  read.csv( 
    "http://slate-interactives-prod.elasticbeanstalk.com/gun-deaths/getCSV.php")

tail(gun.deaths)
summary(gun.deaths)

wa <- subset(gun.deaths, state=="WA")