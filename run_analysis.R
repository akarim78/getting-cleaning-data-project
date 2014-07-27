url<- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if(!file.exists("data")){
    dir.create('data')
}
download.file(url, destfile='data/sensor_data.zip', method='curl')
files<-unzip('data/sensor_data.zip',list=TRUE)

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
y_data_f <- factor(y_data$activity)
levels(y_data_f) = activity_labels$V2

## Concatenating training and test subject data
subject_data<-rbind(subject_train,subject_test)
names(subject_data)<-c('subject')

## Binding all the columns
all_data<-cbind(x_data, subject_data, y_data_f)

