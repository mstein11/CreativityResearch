library(Hmisc)
library(corrgram)

setwd("/Users/joschaeirich/Desktop")

date_Cologne <- "2017-10-11"
date_Bamberg <- "2017-10-16"

creativiyScores <- read.csv2("All users Marius.csv")
sensorData <- read.csv2("Sensor.csv")
moodData <- read.csv2("mood.csv")

sensorData$relevantTime <- as.POSIXct(sensorData$local_timestamp)
sensorData$relevantDate <- strftime(sensorData$relevantTime,"%Y-%m-%d")
sensorData$relevantTime <- strftime(sensorData$relevantTime,"%H")

sensorData$Intervall <- ifelse(sensorData$relevantTime >= "02" & sensorData$relevantTime < "05",0,  
                             ifelse(sensorData$relevantTime >= "05" & sensorData$relevantTime < "11",1,
                                    ifelse(sensorData$relevantTime >= "11" & sensorData$relevantTime < "15",2,
                                           ifelse(sensorData$relevantTime > "15" & sensorData$relevantTime < "19",3,4))))                                        

moodData$relevantTimeframe <- as.POSIXct(moodData$local_timestamp)
moodData$relevantDate <- strftime(moodData$relevantTimeframe,"%Y-%m-%d")
moodData$relevantTime <- strftime(moodData$relevantTimeframe,"%H")

moodData$Intervall <- ifelse(moodData$relevantTime >= "02" & moodData$relevantTime < "05",0,  
                             ifelse(moodData$relevantTime >= "05" & moodData$relevantTime < "11",1,
                                    ifelse(moodData$relevantTime >= "11" & moodData$relevantTime < "15",2,
                                           ifelse(moodData$relevantTime > "15" & moodData$relevantTime < "19",3,4))))                                        

moodDataCologne <- moodData[moodData$relevantDate == date_Cologne,]
moodDataBamberg <- moodData[moodData$relevantDate == date_Bamberg,]

SensorDataCologne <- sensorData[sensorData$relevantDate == date_Cologne,]
SensorDataBamberg <- sensorData[sensorData$relevantDate == date_Bamberg,]

mergeCologne <- merge(SensorDataCologne, creativiyScores, by="user_id")
mergeCologne <- merge(mergeCologne, moodDataCologne, by=c("user_id","Intervall","relevantDate"))


mergeBamberg <- merge(SensorDataBamberg, creativiyScores, by="user_id")
mergeBamberg <- merge(mergeBamberg, moodDataBamberg, by=c("user_id","Intervall","relevantDate"))


merge <- rbind(mergeCologne, mergeBamberg)

merge<-merge[,c(7:9,15:22,25:48,52,53)]
merge[merge==""] <- NA
merge <- na.omit(merge) 

cor <- rcorr(as.matrix(merge)) 
correlation_coefficient <-as.data.frame(cor$r)
correlation_pValues <- as.data.frame(cor$P)

corrgram(merge)
 