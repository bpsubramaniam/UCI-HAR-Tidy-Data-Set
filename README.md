# UCI-HAR-Tidy-Data-Set
 Human Activity Recognition [HAR] Data Set :: Geting &amp; Tidying script
The Data Set is from the Human Activity Recognition data obtained from 30 subjects for 6 different activities
using Samsung smart phone

Acknowledgement:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
 
The run_analysis.R script does the following:
The data is available in
https://https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

1. Get the Data Set zip file from the website if the file does not exist
2. Unzip and extract all the files
3. Merge Train and Test Data Set into one
4. Extract only the mean and standard deviation measurements from the data set using grep
5. grep the featureName fields that have mean or std (standard deviation) in them
6. Use the names to select the columns of interest from the Data Set
7. Create a combined Data Set with Subjects, Activities and needed feature measurements
8. Create a 2nd Tiday Data Set with Average of each Variable, for each activity and each subject
9. Write the new Tidy Data Set into a file with row name = FALSE as specified

