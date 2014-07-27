# Course Project
## Coursera: Getting and Cleaning Data

This is the repository for the Course Project for Getting and Cleaning Data course from Coursera.

## Dataset
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Instructions
* Clone the project: the dataset is included in the repository and extracted inside data directory.
* Run run_analysis.R: it will generate 2 .txt data file:
1) Combined dataset: merged_dataset.txt
2) Tidy dataset: tidy_data.txt

## Description of the script:
The run_analysis.R script reads a number of txt files, merge them to create a dataset and then generate a tidy dataset according to the requirements.

Details about the tidy data is provided in CodeBook.md

## Note
Reshape2 library will be needed.  
