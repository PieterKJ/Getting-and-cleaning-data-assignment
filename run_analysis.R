#Set working directory to personal map containing the files
setwd("C:/Users/PiKr/Documents/Coursera/Getting and cleaning data/UCI HAR Dataset")

#-------------------------------------------------- 1: Merge the test set and train set---------------------------------------------------#

#Read in train files
xtrain <- read.table(file="./train/X_train.txt")
ytrain <- read.table(file="./train/y_train.txt")
subjectTrain <- read.table(file="./train/subject_train.txt")

#Read in test files
xtest <- read.table(file="./test/X_test.txt")
ytest <- read.table(file="./test/y_test.txt")
subjectTest <- read.table(file="./test/subject_test.txt")

#Combine train files and give appropropriate label
train <- cbind(subjectTrain, ytrain,xtrain)
colnames(train)[c(1,2)] <- c("subject","activity")

#Combine test files and give appropriate label
test <- cbind(subjectTest, ytest, xtest)
colnames(test)[c(1,2)] <- c("subject","activity")

#Merge test and train set
dat <- rbind(train,test)

#--------------------------- 2: extract only the measurments on the mean and stander deviation for each measurement--------------------#

#The original column names reveal which columns contain information on the mean and standard deviation. So we first read in the original column names
features <- read.table(file="features.txt")

#Label the columns with the original names
colnames(dat)[3:ncol(dat)] <- as.character(features$V2)

#Extract all columns containing information on mean and standerd dev. We assume that meanFreq columns also have to be included
MeanStd <- dat[,c(grep("mean", colnames(dat), value=T), grep("std", colnames(dat), value=T))]

#-------------------------------------------------------- 3: Use descripte label names-----------------------------------------------#

#load plyr library to rename values for 'activity'
library(plyr) 

#Change class to factor (necessary to use revalue function)
dat$activity <- as.factor(dat$activity)

#Change factor levels to correct names
dat$activity <- revalue(dat$activity, c("1"="WALKING", "2"="WALKING_UPSTAIRS", "3" ="WALKING_DOWNSTAIRS", "4" = "SITTING", "5" = "STANDING", "6" = "LAYING"))


#-------------------------------------------------------- 4: appropriately label dataset names-------------------------------------------#

#Keep only letters, numbers and "." in the variable names

colnames(dat) <- gsub("-[0-9]",".",colnames(dat)) #replace "-" if followed by number
colnames(dat) <- gsub("\\(","",colnames(dat)) #remove "("
colnames(dat) <- gsub("\\)",".",colnames(dat)) #remove ")"
colnames(dat) <- gsub(",",".",colnames(dat)) #replace "," with "-"
colnames(dat) <- gsub("-",".",colnames(dat)) #repalce "." with "-"
colnames(dat) <- gsub("\\.\\.",".",colnames(dat)) #Drop "." followed by another "."
colnames(dat) <- substring(colnames(dat), 1, nchar(colnames(dat))-1) #drop "." at the end

#-------------------------------------------------------- 5: create second independently dataset-----------------------------------------#

#Use ddply

NewDat <- ddply(dat, .(subjec, activit), function(x) colMeans(x[3:563]))

#Use more interpretable variable names

colnames(NewDat)[3:ncol(NewDat)] <- paste0("(",colnames(NewDat)[3:ncol(NewDat)],")")
colnames(NewDat)[3:ncol(NewDat)] <- paste0("AVG", colnames(NewDat)[3:ncol(NewDat)] )

#Create table in .txt format

write.table(NewDat, file="NewDat.txt", row.names=F)
