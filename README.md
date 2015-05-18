# courseraDataCleaningProject

The purpose of this repo and the R script run_analysis.R is to fulfill the project requirement for the Coursera Data Cleaning Project. As such very little attention was paid to the actual data and its meaning since the purpose of the project was to show facility at cleaning up data and reshaping it. 

Quick Start. Fork repo to computer. In R set the working directory to the new forked directory. Load the script run_analysis.R and run line by line to see how it works. If the working directory is set right, run_analysis should have the data files it needs. 

The underlying data has to do with recognizing what activity a human is doing given smartphone gyroscopic data. Its purpose
is probably to facilitate a machine learning approach which would map the gyro data to the human activity allowing a predictive model. This will undoubtably help the NSA in its continuing efforts to monitor literally our every move, if not our every bowel movement. (The study didn't try to track that. Probably Apple is working on it, and luckily there is still some doubt whether they are backdoored to the NSA. Forgive the pun.)

This repo contains the Human Activity Recognition Using Smartphones Data Set in zipped format: getdata-projectfiles-UCI HAR Dataset.zip. It also contains the unzipped files. The files are obtainable from UCI Machine learning repository at: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

The working script is run_analysis.R which is heavily commented to help understand what it is doing. A short summary would be that 
run_analysis.R :

        1. Merges the training and the test sets to create one data set and labels the data set with descriptive names provided         by the data collector.
        2. Extracts only the measurements on the mean and standard deviation for each measurement. 
        3. Uses descriptive activity names to name the activities in the data set
        4. Appropriately labels the data set with descriptive variable names. (Done in step 1.)
        5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each             activity and each subject.

A couple of notes: To complete 2., the script searches for any column name with mean or std in it, and assumes that is what is wanted for the tidy data set in step 5. Step 4. is actually handled in Step 2, as I decided to create a tidy data set of all the data and then subset the complete data set instead of subsetting the dirty data and then cleaning up the subsetted dirty data. This is more general and hence probably a good idea since the Xy_dataset is tidy and ready for further use.

Good luck with it. 
