
#clear all variables
rm(list = ls())

#load the necessary library
library(dplyr)

print( "Load file...")

filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

# Check if the zip file exists, otherwise download it
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Check if its folder exists, otherwise unzipe the zip file
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


#Load all requested data and store them into dataframes
print( "Store variable in df...")
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("idx","names"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "label"))

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$names)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "id")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$names)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "id")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

#-------------------------------------------------------------------------------------------
# 1- Merges the training and the test sets to create one data set.
#-------------------------------------------------------------------------------------------
print( "Step-1: Merge data..")
X_data <- rbind(x_train, x_test)
Y_data <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(X_data, Y_data, Subject)

#-------------------------------------------------------------------------------------------
# 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#-------------------------------------------------------------------------------------------
print( "Step-2: Extract only the data related to the mean and std..")

# Select all columns that have the keys mean and std:
TidyData <- Merged_Data %>% select(subject, id, contains("mean"), contains("std"))

#-------------------------------------------------------------------------------------------
#3: Uses descriptive activity names to name the activities in the data set.
#-------------------------------------------------------------------------------------------
print( "Step-3: Uses descriptive activity names..")

TidyData$id <- activity_labels[TidyData$id, 2]

#-------------------------------------------------------------------------------------------
# 4: Appropriately labels the data set with descriptive variable names.
#-------------------------------------------------------------------------------------------

print( "Step-4: Appropriately labels the data..")

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("^t", "TimeDomain", names(TidyData))
names(TidyData)<-gsub("^f", "FrequencyDomain", names(TidyData))

names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))

names(TidyData)<-gsub("tBody", "TimeDomainBody", names(TidyData))

names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))

#-------------------------------------------------------------------------------------------
# 5: From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
#-------------------------------------------------------------------------------------------

print( "Step-5: creates a second, independent tidy data ..")

TidyData_avg <- TidyData %>% group_by(subject, activity) %>% summarise_all(funs(mean))

write.table(TidyData_avg, "TidyData_avg1.txt", row.name=FALSE)

#-------------------------------------------------------------------------------------------
# #Check the variable names of the final dataframe
#-------------------------------------------------------------------------------------------

str(TidyData_avg)
TidyData_avg
