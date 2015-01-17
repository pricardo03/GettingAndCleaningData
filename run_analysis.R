### You should create one R script called run_analysis.R that does the following. 
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names. 
#5.From the data set in step 4, creates a second, 
  #independent tidy data set with the average of each variable for each activity and each subject.

#check if is intalled all packages we need
      if (!require("data.table"))   { install.packages("data.table") }  ; require("data.table")
      if (!require("reshape2"))     { install.packages("reshape2") }    ; require("reshape2")

#Label and features 
# read activity labels
      ActivityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2] 
# read column names 
      Features <- read.table("./UCI HAR Dataset/features.txt")[,2] 

# Extract only the measurements on the mean and standard deviation for each measurement. 
      ExtractFeatures <- grepl("mean|std", Features) 

# Load and process X_test & y_test data. 
      X_test <- read.table("./UCI HAR Dataset/test/X_test.txt") 
      y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") 
      subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") 
      names(X_test) = Features 

# Get only the measurements on the mean and standard deviation for each measurement for features. 
      X_test = X_test[,ExtractFeatures] 

# and rename columns 
      y_test[,2] = ActivityLabels[y_test[,]] 
      names(y_test) = c("Activity_ID", "Activity_Label") 
      names(subject_test) = "subject" 

# merge data into a Data Frame 
      TestData <- cbind(as.data.table(subject_test), y_test, X_test) 


#now handled data training x_train & y_train data. 
      XTrain <- read.table("./UCI HAR Dataset/train/X_train.txt") 
      Ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt") 

      SubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt") 
      
      names(XTrain) = Features 

# now get only the measurements on the mean and standard deviation for each measurement for train data.
      XTrain = XTrain[,ExtractFeatures] 

# Load activity data 
      YTrain[,2] = ActivityLabels[YTrain[,1]] 
      names(YTrain) = c("Activity_ID", "Activity_Label") 
      names(SubjectTrain) = "subject" 
 
# merge xTrain and yTrain data 
      TrainData <- cbind(as.data.table(SubjectTrain), YTrain, XTrain) 

# Merge test and train data 
      data = rbind(TestData, TrainData) 
      
      IdLabels   = c("subject", "Activity_ID", "Activity_Label") 
      DataLabels = setdiff(colnames(data), IdLabels) 
      melt_data      = melt(data, id = IdLabels, measure.vars = DataLabels) 

# here Apply mean function to dataset using dcast function 
      TidyDataSet = dcast(melt_data, subject + Activity_Label ~ variable, mean) 

#Finally write TidyDataSet in a file
      write.table(TidyDataSet, file = "./TidyDataSet.txt") 
