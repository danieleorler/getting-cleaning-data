# Producing the dataset #

## Merges the training and the test sets to create one data set ##
Both the test and the train data are composed by 3 files. One of them contains all the measurments while the others contains information about the activity and subject measured.
These 3 files have a commen extension (.txt) so it is quite simple to get them, load their data and merge them as done in function mergeFolderFile in file build_main_dataset.R.
Since they are merged by rows.name, the function merge add the rows.name of each dataset, sice we do not want all that useless columns we just remove them while merging.
It has been decided to merge the dataset folder by folder (first test and then train) resulting in two dataset of the same type.
The final step was to append the second to the first in order to produce a dataset containing all the desired data.

## Extracts only the measurements on the mean and standard deviation for each measurement ##
In order to get the varibles describing mean and standard deviation, it has ben decided to filter the variables names with a regular expression looking for the string 'mean' or 'std', all other columns where dropped.

## Uses descriptive activity names to name the activities in the data set ##
Headers (columns names for each measure) are stored into a separate file. 
The column names are stored in a column but we need them to be a row.
That's why the column containing variable names is transposed, filtered as described above and used as dataframe's column names.

## Appropriately labels the data set with descriptive activity names ##
The dataset now has all the measurments we need but the activity are labeled with numbers.
There is a file containing a textual description for each of those numbers.
To obtain have activities described with meaningfull strings the dataset has been joined with the activity description.

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject ##
The dataset now is complete and tidy, to aggregate its data by activity and subject it was used the function aggregate as on group_data.R file.
Before aggregating the data the columns was rearranged in order to have all the 'qualitative variables' at the beginning and the 'quantitative variables' after. This way it was easier to aggregate data.

# Variables #
__activity_description__    textual description of the activity  
__activity_id__ numerical identifier of the activity  
__subject()__   numerical identifier of the subject  
tBodyAcc-mean()-X  
tBodyAcc-mean()-Y  
tBodyAcc-mean()-Z  
tBodyAcc-std()-X  
tBodyAcc-std()-Y  
tBodyAcc-std()-Z  
tGravityAcc-mean()-X  
tGravityAcc-mean()-Y  
tGravityAcc-mean()-Z  
tGravityAcc-std()-X  
tGravityAcc-std()-Y  
tGravityAcc-std()-Z  
tBodyAccJerk-mean()-X  
tBodyAccJerk-mean()-Y  
tBodyAccJerk-mean()-Z  
tBodyAccJerk-std()-X    
tBodyAccJerk-std()-Y    
tBodyAccJerk-std()-Z    
tBodyGyro-mean()-X  
tBodyGyro-mean()-Y  
tBodyGyro-mean()-Z  
tBodyGyro-std()-X   
tBodyGyro-std()-Y   
tBodyGyro-std()-Z   
tBodyGyroJerk-mean()-X  
tBodyGyroJerk-mean()-Y  
tBodyGyroJerk-mean()-Z  
tBodyGyroJerk-std()-X   
tBodyGyroJerk-std()-Y   
tBodyGyroJerk-std()-Z   
tBodyAccMag-mean()  
tBodyAccMag-std()   
tGravityAccMag-mean()   
tGravityAccMag-std()    
tBodyAccJerkMag-mean()  
tBodyAccJerkMag-std()   
tBodyGyroMag-mean() 
tBodyGyroMag-std()  
tBodyGyroJerkMag-mean() 
tBodyGyroJerkMag-std()  
fBodyAcc-mean()-X   
fBodyAcc-mean()-Y   
fBodyAcc-mean()-Z   
fBodyAcc-std()-X    
fBodyAcc-std()-Y    
fBodyAcc-std()-Z    
fBodyAccJerk-mean()-X   
fBodyAccJerk-mean()-Y   
fBodyAccJerk-mean()-Z   
fBodyAccJerk-std()-X    
fBodyAccJerk-std()-Y    
fBodyAccJerk-std()-Z    
fBodyGyro-mean()-X  
fBodyGyro-mean()-Y  
fBodyGyro-mean()-Z  
fBodyGyro-std()-X   
fBodyGyro-std()-Y   
fBodyGyro-std()-Z   
fBodyAccMag-mean()  
fBodyAccMag-std()   
fBodyBodyAccJerkMag-mean()  
fBodyBodyAccJerkMag-std()   
fBodyBodyGyroMag-mean() 
fBodyBodyGyroMag-std()  
fBodyBodyGyroJerkMag-mean() 
fBodyBodyGyroJerkMag-std()  

