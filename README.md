# Getting and Cleaning Data
Getting and Cleaning Data Project


This is a repository for project of Getting and Cleaning Data Coursera course. 
    Johns Hopkins University.

## Course Project
(find all project-related materials in the UCI HAR Dataset directory, however, copies of the important files have been put into this main directory to fulfill the submission requirement)

1. Unzip the original source (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into a folder on your computer, sample: C:\Users\UserName\Documents\GettingAndCleaningData

2. Run run_analysis.R into C:\Users\UserName\Documents\GettingAndCleaningData\UCI HAR Dataset\

3. In RStudio: setwd("C:\\\\Users\\\\UserName\\\\Documents\\\\R\\\\UCI HAR Dataset\\\\"), followed by: source("run_analysis.R")

4. Use data <- read.table("TidyDataSetSource.txt") to read the data. It is 180x68 because there are 30 subjects and 6 activities, thus "for each activity and each subject" means 30 * 6 = 180 rows. Note that the provided R script has no assumptions on numbers of records, only on locations of files.

