TidyDataProject
===============

This repo contains an R script and associated files to create a tidy data set from the original accelerometer dataset linked in the course project.

The original dataset can be downloaded from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The repo has the following files-

README.md
	- This file.

run_analysis.R
	- R script to create the tidy data set from the original data according to this recipe
	1. Merges the training and the test sets to create one data set.
	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	3. Uses descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names. 
	5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

	- To run, download the original dataset (will create getdata_projectfiles_UCI HAR Dataset/) and run the run_analysis.R script from the parent directory.
	- The script will write the tidy dataset to tidy_means_std_avg.txt

CodeBook.md
	- The codebook for the tidy dataset that describes the column variables in the dataset.
