library(reshape2)

url<- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if(!file.exists("data")){
    dir.create('data')
}
download.file(url, destfile='data/sensor_data.zip', method='curl')
files<-unzip('data/sensor_data.zip',list=TRUE)

## 1. Merges the training and the test sets to create one data set.
## Getting list of features
features <- read.table('data/UCI HAR Dataset/features.txt', header=FALSE)
## Getting list of activity label
activity_labels<- read.table('data/UCI HAR Dataset/activity_labels.txt', header=FALSE)

## Getting all training data
x_train <- read.table('data/UCI HAR Dataset/train/X_train.txt', header=FALSE)
y_train <- read.table('data/UCI HAR Dataset/train/y_train.txt', header=FALSE)
subject_train <- read.table('data/UCI HAR Dataset/train/subject_train.txt', header=FALSE)

## Getting all test data
x_test <- read.table('data/UCI HAR Dataset/test/X_test.txt', header=FALSE)
y_test <- read.table('data/UCI HAR Dataset/test/y_test.txt', header=FALSE)
subject_test <- read.table('data/UCI HAR Dataset/test/subject_test.txt', header=FALSE)

## Concatenating training and test X data
x_data<-rbind(x_train, x_test)
names(x_data)<-features$V2

## Concatenating training and test Y data along with replacing with activity labels
y_data<-rbind(y_train, y_test)
names(y_data)<-c('activity')

## 3. Uses descriptive activity names to name the activities in the data set
y_data_f <- factor(y_data$activity)
levels(y_data_f) = activity_labels$V2

## Concatenating training and test subject data
subject_data<-rbind(subject_train,subject_test)
names(subject_data)<-c('subject')

## Binding all the columns and merging is done
all_data<-cbind(x_data, subject_data, y_data_f)
names(all_data)[names(all_data) == 'y_data_f'] <- 'activity'

## Writing data for backup
write.table(all_data, file = 'merged_dataset.txt', col.names=TRUE)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
col_selection <- grep("*[Mm]ean()|*[Ss]td()|activity|subject",names(all_data),ignore.case=TRUE)
selected_data <- all_data[, col_selection]

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
temp_data <- melt(selected_data,id=c("activity", "subject"))
tidy_data <- dcast(temp_data, activity + subject ~ variable,mean)
head(tidy_data)
## Create a file with the new tidy dataset
write.table(tidy_data,"tidy_data.txt")
