#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Download the data set
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile ="Dataset.zip")

# decompressed the zip file
unzip("Dataset.zip")

#Reading all the data

# the training data set
trainData<-read.table("./UCI HAR Dataset/train/X_train.txt")
trainLabel<-read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#the testing data set
testData<-read.table("./UCI HAR Dataset/test/X_test.txt")
testLabel<-read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

#feature data set
features<-read.table("./UCI HAR Dataset/features.txt")

#the activity labels
activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activity)<-c("activityid", "activityname")

# Complete the training data set
#assign the variable/column names
colnames(trainData)<-features$V2
colnames(trainLabel)<-"activityid"
colnames(subject_train)<-"subjectid"
#Combine the data set
trainData<-cbind(trainLabel,subject_train,trainData)

# Complete the testing data set
#assign the variable/column names
colnames(testData)<-features$V2
colnames(testLabel)<-"activityid"
colnames(subject_test)<-"subjectid"
#Combine the data set
testData<-cbind(testLabel,subject_test,testData)

# (1) merge the training and testing data set
wholedata<-rbind(trainData,testData)

# (2) Extracts only the measurements on the mean and standard deviation for each measurement
mean_and_std <- sort(c(grep("activityid" , names(wholedata)), 
                     grep("subjectid" , names(wholedata)), 
                     grep("mean.." , names(wholedata)), 
                     grep("std.." , names(wholedata)))
)
datawithmeanandstd<-wholedata[,mean_and_std]

#Using descriptive activity names to name the activities in the data set
datawithmeanandstdwithacivityname<-merge(activity, datawithmeanandstd, by="activityid",all.x=TRUE)

# tidy data set with the average of each variable for each activity and each subject
tidydata <- aggregate(. ~subjectid + activityid, datawithmeanandstd, mean)
#add descriptive activity names, if you used the already added data set in last step, the mean will screw it up
tidydata <- merge(activity, tidydata, by="activityid",all.x=TRUE)

# export the tidy data set
write.table(tidydata, "tidydata.txt", row.name=FALSE)
tidydata<-read.table("tidydata.txt")
