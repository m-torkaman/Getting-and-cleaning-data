## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject.



## Setting your working directory 
setwd("E:/coursera/3.GettingandCleaningData/CourseProject/UCI HAR Dataset/")
## Loading packages
library(reshape2)
library(data.table)
library(dplyr)

## Finding required columns' positions and associated labels (only mean and standard diviation measurements)   
features <- read.table("./features.txt", header = FALSE, stringsAsFactors = FALSE)
clmn_positions <- grep("mean|std", features[,2])
clmn_names     <- grep("mean|std", features[,2], value = TRUE)
clmn_names <- sub("\\()", "", clmn_names)

activityLabel  <- read.table("./activity_labels.txt", header = FALSE, stringsAsFactors = FALSE)

## Test Group Data
## Loading and merging Activity IDs with their associated labels
testActivityID <- read.table("./test/y_test.txt", header = FALSE)
testActivity   <- as.data.table(merge(testActivityID, activityLabel, all = TRUE)[,2])

## Reading data and selecting and renaming required columns (for mean/standard diviation)
testData <- read.table("./test/X_test.txt", header = FALSE)
testData <- select(testData, clmn_positions)
names(testData) <- c(clmn_names) 

## Merging test subject IDs and Activity Labels with test group data (column-wise)
testSubjectID <- read.table("./test/subject_test.txt", header = FALSE)[,1]
testData <- cbind(testSubjectID, testActivity, testData, stringsAsFactors = FALSE)

## Appropriate column names
setnames(testData, "testSubjectID", "subject")
setnames(testData, "V1", "activity")

## Train Group data
## Loading and merging Activity IDs with their associated labels
trainActivityID <- read.table("./train/y_train.txt", header = FALSE)
trainActivity <- as.data.table(merge(trainActivityID, activityLabel, all = TRUE)[,2])

## Reading data and selecting and renaming required columns (for mean/standard diviation)
trainData <- read.table("./train/X_train.txt", header = FALSE)
trainData <- select(trainData, clmn_positions)
names(trainData) <- c(clmn_names) 

## Merging test subject IDs and Activity Labels with test group data (column-wise)
trainSubjectID <- read.table("./train/subject_train.txt", header = FALSE)[,1]
trainData <- cbind(trainSubjectID, trainActivity, trainData, stringsAsFactors = FALSE)

## Appropriate column names
setnames(trainData, "trainSubjectID", "subject")
setnames(trainData, "V1", "activity")

## Merging Test and Train Group Data (raw-wise) 
allData <- rbind(testData, trainData)

############

## Creating tidy dataset with the average of each variable for each activity 
## and each subject.

## Melting dataset by id variables and measure variables 
meltData <- melt.data.table(allData, id.vars = c("subject", "activity"), 
                          measure.vars = c(3:81) , variable.name = "features")
## creating tidy dataset of id variables and mean of measure vaiables.
tidyMeanData <- dcast.data.table(meltData, subject + activity ~ features, mean)
## writing tidy data to disc
write.table(tidyMeanData, file = "./tidyData.txt", rowname = FALSE)
