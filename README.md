  # Getting and Cleaning Data

  ## Course assignment

You should create one R script called run_analysis.R that does the following.

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive activity names.
 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  ## Steps to work on this assignment
 1. Download the data source from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and save it into one of your PC drives . Unzip the file to create UCI HAR Dataset folder. 
 2. Set UCI HAR Dataset as your working directory using setwd() function in R or RStudio.
 3. Download ("run_analysis.R") from the repo and place it to your working directory.
 4. Run source("run_analysis.R") in R or Rsudio.
 5. After the script being run, you will have a new tidy dataset created in your working directory called “tidyData.txt”, which will contain with the average of each variable (feature) for each activity and each subject.

  ## Required packages
run_analysis.R file will help you to load the dependencies automatically. It depends on reshape2 and data.table, and dplyr  packages. If you don’t have the packages installed in your R or RStudio, you need to install them first using install.packages () function.
