# GettingAndCleaningData-Week-4-Assignment

Note: Working directory should be the folder "UCI HAR Dataset"

run_analysis.R file process the data according to the assignment instructions as follows.

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set.
4) Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# step 1:
1) Reading the training sets as x_train, y_train, subject_train
2) Reading the test sets as x_test, y_test, subject_test
3) row wise binding the x_train and x_test to atain the complete x table
4) row wise binding the y_train and y_test to atain the complete y table
row wise binding the subject_train and subject_test to atain the complete subject table
x, y and subject tables are consistent with total 10299 rows. Now we can merge them column wise to attain the complete "data".

# step 2:
1) we have to replace the column names in the "data" with their appropriate names.
2) Subject is the first column in the "data"
3) After "subject",  561 column represents the list of all features
4) Last column represent labels for activity
5) Filter out the data set with mean() and std() contained column names

# step 3:
1) Reading the activity labels file for the descriptive activity names
2) Replacing the activity code with the activity labels

# step 4:
1) List of short abbrivation to be replaced
2) List of descriptive names to be in placed
3) Replacing using gsub

# step 5:
1) Convert the subject column in to factor
2) Import library dplyr
3) Computing average of each variable for each activity and each subject.
