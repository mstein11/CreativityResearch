
setwd("/Users/joschaeirich/Desktop/")

### read the table with user and test ids 
idTabel <- read.csv2("detroit data full1.csv")

### read the table with mood entries of users
mood <-read.csv2("detroit data full mood.csv")

### read marius and qi torrence tests
torrenceDataMarius <- read.csv2("detroit data full assessment marius.csv")
torrenceDataQi <- read.csv2("detroit data full assessment qi.csv")

### connect idTable with moodTable by using equal user ids
merge <- merge(idTabel, mood, by="user_id")

### delete unecessary columns and rename first column
merge <- merge[,c(2,35,36,41:45)]
colnames(merge)[1] <- "Test_Number"

### merge data again with torrence tests
merge <- merge(merge,torrenceDataMarius, by="Test_Number")
merge <- merge[,c(2,3,9:32)]

### create pleasance and activation data set
pleasantData <- merge[,-c(2)]
activationData <- merge[,-c(1)]

### calculate mean correlation for pleasance and activation 
(sum(apply(pleasantData,2, function(col)cor(col, pleasantData$pleasant)))-1)/25
(sum(apply(activationData,2, function(col)cor(col, activationData$activation)))-1)/25

### create correlation table for pleasance and activation 
pleasance <- apply(pleasantData,2, function(col)cor(col, pleasantData$pleasant))
activation <- apply(activationData,2, function(col)cor(col, activationData$activation))

### write table to desktop
write.table(pleasance,  sep=";",file="/Users/joschaeirich/Desktop/pleasance.csv")
write.table(activation,  sep=";",file="/Users/joschaeirich/Desktop/activation.csv")


