This R program was designed to achieve the following functions:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* In the ¡°run_analysis.R¡± , the original data set was downloaded with function ¡°download.file¡±  and decompressed by ¡°unzip¡±.
* Then all the data were imported by function ¡°read.table¡± and combined with function ¡°cbind¡± or ¡°rbind¡±. 
* To extract the data from mean or std calculation, a vector contains the index of rows of the ¡°activityid¡±, "subjectid" and all qualified variables were extracted by ¡°grep¡± function and sorted.  The combined data set was then subsetted by this vector.     
* The descriptive activity names were then added to the data set by ¡°merge¡± function.
* The tidy data set with the average of each variable for each activity and each subject was calculated by function ¡°aggregate¡±  from the data set before descriptive activity name added, and the descriptive activity name was added back by ¡°merge¡±. 
* At the last step, the tidy data set was exported by function ¡±write.table¡±
