## run_analysis.R does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#

# Set of default packages to source on startup (not all packages will be used)
        library(dplyr)
        library(tidyr)
        library(reshape2)


## 1. Merges the training and the test sets to create one data set.

        ## Read in features.txt, a list of features that will be column headers
        features = read.table("features.txt", sep="")       # These features represent the column headers in the tidy data
                                                            # frame that is being created
        ## Read in data tables

        # Read in Training data and insert subject data into first column & insert independent variable Activity into second column
        X_train = read.table("X_train.txt", sep="")
        names(X_train) = features$V2                        # Set column headers to features list
        X_train = tbl_df(X_train)                           # Convert data frame to table for use with dplyr

        y_train = read.table("y_train.txt")
        y_train = tbl_df(y_train)                           # Convert data frame to table for use with dplyr
        y_train = rename(y_train, activity=V1)              # Rename column header to "subject"

        Xy_train = bind_cols(y_train, X_train)              # Combine independent X variables to dependent y variable

        subject_train = read.table("subject_train.txt", sep="")
        subject_train = tbl_df(subject_train)               # Convert data frame to table for use with dplyr
        subject_train = rename(subject_train, subject=V1)   # Rename column header to "subject"

        Xy_train  = bind_cols(subject_train,Xy_train)

        # Read in Test data and insert subject data into first column & insert independent variable Activity into second column
        X_test = read.table("X_test.txt", sep="")
        names(X_test) = features$V2                         # Set column headers to features list
        X_test = tbl_df(X_test)                             # Convert data frame to table for use with dplyr

        y_test = read.table("y_test.txt")
        y_test = tbl_df(y_test)                             # Convert data frame to table for use with dplyr
        y_test = rename(y_test, activity=V1)

        Xy_test = bind_cols(y_test, X_test)                 # Insert y_test column into X_test table

        subject_test = read.table("subject_test.txt", sep="")
        subject_test = tbl_df(subject_test)                 # Convert data frame to table for use with dplyr
        subject_test = rename(subject_test, subject=V1)     # Rename column header to "subject"

        Xy_test = bind_cols(subject_test,Xy_test)           # add subject column to X_test

        ## Merge the Training and Test dataset
        Xy_datamerge = bind_rows(Xy_train,Xy_test)          # Combine the training and test data sets

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
        Xy_dataset = select(Xy_datamerge,contains("subject"), contains("activity"), contains("mean"), contains("std"))

## 3. Uses descriptive activity names to name the activities in the data set
        activity_labels = read.table("activity_labels.txt")
        activity_labels_vec = activity_labels[ , "V2"]
        # Turn activities coded as numbers into factors based on activity_labels.txt
        Xy_dataset$activity = factor(Xy_dataset$activity, levels = c(1,2,3,4,5,6), labels=activity_labels_vec)

## 4. Appropriately labels the data set with descriptive variable names.
#     In the first section, I replaced the V3...Vx variables with the corresponding features from the feature list.
#     I am leaving the current column names because they have obviously been well thought out.
#     For example: tBodyGyroJerk-mean()-Z means "mean of time domain Body Gyroscopic Jerk along the Z axis.
#     When there is a "f" that means an FFT transform has put it in the frequency domain. (See features_info.txt included in the repo)

       # columnNames = colnames(Xy_dataset)                                # Prints the current column names for inspection
       #  write.table(columnNames, "columnNames.txt", quote=FALSE)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
#     for each activity and each subject.

        Xy_melt = melt(Xy_dataset, id.vars = c("subject", "activity"))

        # Two views of the same data. subject_activity_means lets you easily see for a subject the means of each activity
        # and the activity_subject_means lets you see for an activity the means for each subject.
        subject_activity_means = dcast(Xy_melt, subject+activity~variable, mean)
        activity_subject_means = dcast(Xy_melt, activity+subject~variable, mean) # This is probably the answer wanted by the project question #5

        # Write table to txt file called tidyData.txt with comma delimitation
        write.table(activity_subject_means, "tidyData", row.names=FALSE, sep=",")

## End of file
