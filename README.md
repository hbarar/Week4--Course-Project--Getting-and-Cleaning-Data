Course-Project--Getting-and-Cleaning-Data

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1-Set woking directory (which the original unzipped file is there)
2-Reading  the activity and feature info (type pf the activity and types of the measurements)
3-Loading all the test datasets 
4-Loading all the train datasets 
5-combine Test and Train data as mergedDF
6- Delete the duplicated coloumns from the mergedDF
6-keeping only those columns which reflect a mean or standard deviation 
7-average of each variable(measurements) for each activity and each subject by aggregate function
8-Creates(write) a tidy dataset that consists of the average (mean) value of each variable for each subject and activity type named( tidy-data.txt)
