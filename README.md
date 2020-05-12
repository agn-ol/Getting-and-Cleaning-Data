# Getting and Cleaning Data - Course Project 

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following: 
1. Loads variables and activities names 
2. Loads and joins data 
   - Loads X_train data  
   - Selects columns that contain mean or standard deviation 
   - Loads y_train data 
   - Replaces activity with descruptive name 
   - Loads subject_train data 
   - Joins x and y datasets ,activity and subject data 
   - Repeates previous steps for test data 
3. Joins train and test datasets 
4. Deletes unused data 
5. Changes column names 
6. Creates dataset that contains average values for each subject and activity 
7. Writes this dataset into .txt file 

The end result is shown in the file averagedata.txt. 

Description and information about used datasets can be found in CodeBook.md file. 