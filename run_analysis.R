##Getting and Cleaning Data Project
##Data collected from accelerometer from the Samsumg Galaxy S smartphone. Link "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
You should create one R script called run_analysis.R that does the following.

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
######################### Code starts here #############################


## Reading data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt") 

## Merges the training and the test sets to create one data set.
## Merging training data and adding column names:
train_data <- cbind(y_train, subject_train,X_train)
colnames(activity_labels)<-c("activity#","activity")
colnames(subject_train) <- "subId"
colnames(x_train) <- features[,2]
colnames(y_train) <- "activity#"

## Merging test data and adding column names:
test_data <- cbind(y_test, subject_test, X_test)
colnames(subject_train) <- "subId"
colnames(X_train) <- features[,2]
colnames(y_train) <- "activity#"
## Merging both test and training data
merged_data <- cbind(train_data, test_data)

## Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_data <- merged_data[,grepl("mean|std|subject|activityId")]

## tidy data
tidy_data<- ddply(mean_std_data, c("subject","activity"), numcolwise(mean))
write.table(tidy_data, file = "./tidy_data.txt")

