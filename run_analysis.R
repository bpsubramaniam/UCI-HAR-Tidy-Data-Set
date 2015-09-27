# Human Activity Recognition [HAR] Data Set :: Geting & Tidying script
#
# Acknowledgement:
#
# Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity 
# Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International 
# Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


URLforHAR <- "https://https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

zipFileName <-"./getdata_projectfiles_UCI HAR Dataset.zip"


# Get the Data Set zip file from the website if the file does not exist
# Unzip and extract all the files

if (file.exists(zipFileName) == FALSE) {
  download.file(URLforHAR, destfile = zipFileName)
}

DirForFiles <- "./UCI HAR Dataset"

if (file.exists(DirForFiles) == FALSE) {
  unzip(zipFileName)
}

# Merge Train and Test Data Set into one

XTrainDF <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
XTestDF  <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)

XMergeDF <- rbind(XTrainDF, XTestDF)

yTrainDF <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
yTestDF <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)

yMergeDF <- rbind(yTrainDF, yTestDF)

subjTrainDF <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subjTestDF <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)

subjMergeDF <- rbind(subjTrainDF, subjTestDF)


# Extract only the mean and standard deviation measurements

features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
names(features) <- c("featureID", "featureName")

# grep the featureName fields that have mean or std (standard deviation) in them

fieldsOfInterest <- grep("-mean\\(\\)|-std\\(\\)", features$featureName)

# the above fields alone to be selected from xMergeDF

XSelectDF <- XMergeDF[,fieldsOfInterest]
names(XSelectDF) <- features[fieldsOfInterest, 2]

### Use descriptive activity names to name activities in the data set

activityNames <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
names(activityNames) <- c("activityID", "activityName")

#Based on the yMergeDF ID get the Name from activityNames and use that for setting the activity Names 
yMergeDF[,1] <- activityNames[yMergeDF[,1],2]
# Appropriately name the heading as Activities
names(yMergeDF) <- "Activities"

# Appropriately name the Subject column 
names(subjMergeDF) <- "Subjects"

# Create a combined Tidy Data Set of Subjects, y activities and X Selected COlumns

CombinedDF <- cbind(subjMergeDF, yMergeDF, XSelectDF)

# Create a 2nd Tiday Data Set with Average of each Variable, for each activity and each subject

ColumnCount <- ncol(CombinedDF)
ColumnsToAvg <- CombinedDF[,3:ColumnCount]

NewAvgTidyDS <- aggregate(ColumnsToAvg, list(CombinedDF$Subjects, CombinedDF$Activities), mean)
names(NewAvgTidyDS)[1] <- "Subjects"
names(NewAvgTidyDS)[2] <- "Activities"

# Write the new Tidy Data Set into a file with row name = FALSE as needed

write.table(NewAvgTidyDS, file="./UCI HAR AVG.txt", row.names=FALSE)

# Way to read the above file
# tidyDF <- read.table("./UCI HAR AVG.txt", header=TRUE)



