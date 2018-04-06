
# Loading packages 
library(plyr)
library(dplyr)

# Set the working directory : It's supposed that the whole zip data was
# already downloaded and unzip in (working directory)

setwd("C:\\Users\\hassan\\Desktop\\TEST")

#READING  FILES

#Features
features<- read.table("./UCI HAR Dataset/features.txt") 
dim(features) # is 561 as the X_train and X_test number of variables

#Activity labels
activity_labels<- read.table("./UCI HAR Dataset/activity_labels.txt")
# is a reference data frame with numbers corresponding each activities

# Reading All Data related to TEST 
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test<- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
test<- cbind(subject_test, y_test, X_test)


## Reading All Data related to Train 

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
subject_train<- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
train<- cbind(subject_train, y_train, X_train)

# MERGE TRAIN AND TEST DATASETS VERTICALLY.

mergedDF<-rbind(train,test)

# Change all variables names: 
names(mergedDF)<-c("subject","activity_num",as.character(features$V2))

#checking activity occurrencies for each subject(person)
table(mergedDF$activity_num,mergedDF$subject) 
#Or if you wanna check the occurances not based on the number
# but by the cossresponding name of the activity . 
# So we can add the name of the avtivity (join to the ) mergedDF
names(activity_labels)<-c("activity_num","activity_type")
# note that mergeDF also has a coloumn activity_num 
mergedDF<-join(mergedDF,activity_labels,by='activity_num')
# another coloumn was added named (activity_type)
table(mergedDF$activity_type,mergedDF$subject)
# It shows that suppose person#11 ,  53 timed did Sitting exercise and so on.
#or
table(mergedDF$activity_type=="SITTING",mergedDF$subject)
#---------------------------------------------------------------

# STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.

drops <- as.character(features$V2)[duplicated(features$V2)]
# If we don't remove the duplicated coloumn then in select we would encounter error
mergedDF<-mergedDF[ , !(names(mergedDF) %in% drops)]
mergedDF<-select(mergedDF,contains("subject"), contains("activity_type"), contains("mean"), contains("std"))

#------------------------------------------------------------------

#STEP 3:Uses descriptive activity names to name the activities in the data set---ALREADY DONE
#STEP 4:Appropriately labels the data set with descriptive variable names---ALREADY DONE

# STEP 5: creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Here we aggregate all the columns of data.frame , grouping by subject and activity type 's Level, 
#and applying the mean function on every coloumns based on the groups of  activity and person(subject)

#subject is integer, activity_type is factor and the rest of columns are all numeric class
mergedDF<- aggregate(mergedDF, by=list(mergedDF$subject, mergedDF$activity_type),  FUN=mean)

#As a result of aggregate two coloumns were added , delete the added colloumns
mergedDF$subject<-NULL
mergedDF$activity_type<-NULL

# rename group 1 and 2
colnames(mergedDF)[1:2]<-c("subject","activity_type")


#Write tidy dataset in a .txt file:
write.table(mergedDF, "tidy_data.txt", row.name=FALSE)
