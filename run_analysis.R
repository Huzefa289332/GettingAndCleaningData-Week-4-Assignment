# Note: Working directory should be the folder "UCI HAR Dataset"

#------------------------------------------------------------------
#                      STEP 1 (START)
#     Merges the training and the test sets to create one data set.
#------------------------------------------------------------------

# Reading the training sets
x_train <- read.table("./train/X_train.txt") # Training set   : Columns from v1-v561
y_train <- read.table("./train/y_train.txt") # Training labels: Single column v1

# Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
subject_train <- read.table("./train/subject_train.txt") # single column v1

# Reading the test sets
x_test <- read.table("./test/X_test.txt") # Test set : Columns from v1-v561
y_test <- read.table("./test/y_test.txt") # Test labels: Single column v1

# Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
subject_test <- read.table("./test/subject_test.txt") # single column v1

# row wise binding the x_train and x_test to atain the complete x table
x <- rbind(x_train, x_test) # Total 10299 rows

# row wise binding the y_train and y_test to atain the complete y table
y <- rbind(y_train, y_test) # Total 10299 rows

# row wise binding the subject_train and subject_test to atain the complete subject table
subject <- rbind(subject_test,subject_train) # Total 10299 rows

# x, y and subject tables are consistent with total 10299 rows. Now we can merge them column wise to attain the complete data.
# subject -> x (features) -> y (output)
data <- cbind(subject, x, y) # Total 10299 rows

# ----------------------------------------------------------------------------------
#                                 STEP 1 END
# ----------------------------------------------------------------------------------


#--------------------------------------------------------------------------------------
#                                 STEP 2 (START)
# Extracts only the measurements on the mean and standard deviation for each measurement.
#-------------------------------------------------------------------------------------

# we have to replace the column names in the "data" with their appropriate names

# Subject is the first column in the "data"
names(data)[1] <- "subject"

# After "subject",  561 column represents the list of all features
# reading features.txt
feature <- read.table("features.txt")
names(data)[2:(length(names(data))-1)] <- as.character(features$V2)

# Last column represent labels for activity
names(data)[length(names(data))] <- "activity"

# Filter out the data set with mean() and std() column names

data_mean_std <- cbind(data[1], data[grepl("std\\(\\)|mean\\(\\)",names(data))], data[length(names(data))])

# ----------------------------------------------------------------------------------
#                                 STEP 2 END
# ----------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------
#                                 STEP 3 (START)
# Uses descriptive activity names to name the activities in the data set.
#-------------------------------------------------------------------------------------

# Reading the activity labels file for the descriptive activity names
label <- read.table("activity_labels.txt")
# Replacing the activity code with the activity labels
data_mean_std$activity <- label[data_mean_std$activity, 2]

# -----------------------------------------------------------------------------------
#                                 STEP 3 END
# -----------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------
#                                 STEP 4 (START)
# Appropriately labels the data set with descriptive variable names.
#-------------------------------------------------------------------------------------

# List of short abbrivation to be replaced
short_name = c("^t", "^f", "BodyBody", "Acc", "Gyro", "Mag")
# List of descriptive names to be placed
desc_name = c("Time", "Frequency", "Body", "Accelerometer", "Gyroscope", "Magnitude")

for(i in 1:length(short_name)){
  names(data_mean_std) <- gsub(short_name[i], desc_name[i], names(data_mean_std))
}

# -----------------------------------------------------------------------------------
#                                 STEP 4 END
# -----------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------
#                                 STEP 5 (START)
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#-------------------------------------------------------------------------------------

# Convert the subject column in to factor
data_mean_std$subject <- factor(data_mean_std$subject)

library(dplyr)

average <- data_mean_std %>% group_by(activity, subject) %>% summarise_all(funs(mean))
write.table(average, "Data_Tidy.txt", row.name=FALSE)

# -----------------------------------------------------------------------------------
#                                 STEP 5 END
# -----------------------------------------------------------------------------------
