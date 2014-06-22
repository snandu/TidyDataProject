# Read in the training data
training_data <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset//train/X_train.txt")
# Combine with the training activity data
training_activity <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset//train/y_train.txt")
training_data <- cbind(training_activity, training_data)
# Combine with the training subject
training_subject <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset//train/subject_train.txt")
training_data <- cbind(training_subject, training_data)

# Read in the test data
test_data <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset//test/X_test.txt")
# Combine with the test activity data
test_activity <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset//test/y_test.txt")
test_data <- cbind(test_activity, test_data)
# Combine with the test subject
test_subject <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset//test/subject_test.txt")
test_data <- cbind(test_subject, test_data)

# Merge the training and the test sets to create one data set.
merged_data <- rbind(training_data, test_data)

# Read in the feature list
features_data <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
features <- as.character.factor(features_data$V2)

# Appropriately label the data set with descriptive variable names.
names(merged_data) <- c("subject", "activity", as.character(features))

# Extract only the measurements on the mean and standard deviation for each measurement. 
mean_std_cols <- grep("mean\\(\\)|std\\(\\)", names(merged_data))
cols_of_interest <- c(1:2, mean_std_cols)
mean_std_data <- merged_data[,cols_of_interest]

# Use descriptive activity names to name the activities in the data set
act_desc <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
mean_std_data$activity <- sapply(mean_std_data$activity, function(x) act_desc[x, "V2"])


# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
# First melt the data set
library(reshape2)
mean_std_melted <- melt(mean_std_data, id.vars=c("subject", "activity"))

# Find mean for each (subject, activity, feature)
mean_std_avg <- dcast(mean_std_melted, subject + activity ~ variable, mean)

# cleanup and change names appropriately
nm <- names(mean_std_avg)
nm <- gsub("\\(", "", nm)
nm <- gsub("\\)", "", nm)
nm[-(1:2)] <- gsub("^t", "time", nm[-(1:2)])
nm[-(1:2)] <- gsub("^f", "frequency", nm[-(1:2)])
nm[-(1:2)] <- gsub("^", "avg_", nm[-(1:2)])

names(mean_std_avg) <- nm

# Write out tidy data table
write.table(mean_std_avg, file="tidy_means_std_avg.txt", row.names=FALSE)
