getdata-003-project
===================

Coursera Getting and Cleaning Data Course Project

#run_analysis.R #

## Script Purpose 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Script Prepration 
For this script to run you must:

* set you working directory
* ensure that you have the reshape2 R package

## Script Steps

** YOU MUST SET YOUR WORKING DIRECTORY **

1. Load training and test data
2. Assign column names to the data sets
3. Combine test and traing data sets in into one data set
4. Extract columns that contatin only mean and standard dev
 4. Columns selected contianed either the word "mean" or "std"
5. Label activies by using activity names instead of numbers
6. transform the column names to be more readable
7. write the dataset to a file
8. Creates a second data set with the average of each variable for each activity and each subject
 8. Get column names with numeric values
 8. melt the data to group by subject and activity
 8. write get the mean the data for each variable grouped by subject and activity
 8. write out the file of summarized data


## Data Inputs
* data file: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip
 * more info: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/
 
## Data Outputs
1. output.txt - a tab dilimeted file containing the unsummarized data usded to create the tidy data
2. tidyData.txt - a tab dilimeted file containing the unsummarized data the average of each variable for each activity and each subject.