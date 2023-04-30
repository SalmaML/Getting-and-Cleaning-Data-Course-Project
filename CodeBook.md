#CodeBook

As described in the project requirement, the run_analysis.R file should perform the following tasks:

### Download the dataset from the website
Dataset is downloaded, unziped and extracted under the folder named ‘UCI HAR Dataset’

### Extract each data and assign it to a data frame as explained below.
The following data are read and stored in different dataframes:
- features.txt file -> feature
- activity_labels.txt ->  activity_labels
- test/X_test.txt     -> x_test  
- test/y_test.txt     -> y_test
- train/X_train.txt   -> x_train
- train/y_train.txt   -> y_train
- test/subject_train.txt -> subject_train
- test/subject_test.txt -> subject_test

### Step 1: Merges training and test sets to create one data set 
X df is created to merge both x_train and x_test dataframes.
Y df is created to merge both y_train and y_test dataframes.
Subject df is created to merge both subject_train and subject_test dfs.
Merged_Data  df is created to merge Subject, Y, X df.

### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
TidyData is obtained from Merged_Date df by selecting only columns that have the svd and mean keys.

### Step 3: Uses descriptive activity names to name the activities in the data set
Replace the id activity by its name that is taken from the 2nd column of the activity_labels variable.

### Step 4: Appropriately labels the data set with descriptive variable names
id column in TidyData renamed into activities ( linked to the 2nd column of the activity_labels variable)
All 'Acc' words in TidyData column’s name replaced by Accelerometer
All 'Gyro' words in TidyData  column’s name replaced by Gyroscope
All 'Mag' words in TidyData  column’s name replaced by Magnitude
BodyBody in TidyData  column’s name replaced by Body
Also, all variables starting with character f in TidyData column’s name replaced by Frequency
All variables starting with character t in TidyData   column’s name replaced by Time

### Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
TidyData_avg is created from TidyData df by taking the means of each variable for each activity and each subject, after groupped by subject and activity.
The TidyData_avg df is exported into TidyData_avg.txt file.


