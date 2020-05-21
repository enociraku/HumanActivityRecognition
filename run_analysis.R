run_analysis <- function()
{
  # The run_analysis.R is saved at the "UCI HAR Dataset" folder.
  # Change the working directory to where the datasets are.
  
  ## Load the features.txt and activity_labels.txt tables
  features <- read.table("features.txt")
  activity_labels <- read.table("activity_labels.txt")
  
  # Rename the columns of the two dataframes:
  names(features) <- c("Feature.ID", "Feature.Name")
  names(activity_labels) <- c("Activity.ID", "Activity.Name")
  
  ## Training dataset
  # Read the training set files with read.table()
  train_path <- "train/"
  subject_train <- read.table(paste(train_path, "subject_train.txt", sep = ""))
  X_train <- read.table(paste(train_path, "X_train.txt", sep = ""))
  y_train <- read.table(paste(train_path, "y_train.txt", sep = ""))
  
  # Rename the columns of the dataframes:
  names(subject_train) <- "Subject.ID"
  names(X_train) <- features$Feature.Name
  names(y_train) <- "Activity.ID"
  
  # Join the y_train and activity_labels datasets so that you have the mapping between
  # Activity.ID and Activity.Name as they appear in the training dataset
  # You need the "dplyr" library to use the inner_join() function.
  activity_train <- inner_join(y_train, activity_labels) # Joining, by = "Activity.ID"
  
  # Merge all three dataframes in the final train dataset:
  data_train <- cbind(subject_train, X_train, activity_train)
  
  ### We are going to repeat the same process for the test dataset:
  
  ## Test dataset
  # Read the test set files with read.table()
  test_path <- "test/"
  subject_test <- read.table(paste(test_path, "subject_test.txt", sep = ""))
  X_test <- read.table(paste(test_path, "X_test.txt", sep = ""))
  y_test <- read.table(paste(test_path, "y_test.txt", sep = ""))
  
  # Rename the columns of the dataframes:
  names(subject_test) <- "Subject.ID"
  names(X_test) <- features$Feature.Name
  names(y_test) <- "Activity.ID"
  
  # Join the y_test and activity_labels datasets so that you have the mapping between
  # Activity.ID and Activity.Name as they appear in the test dataset
  # You need the "dplyr" library to use the inner_join() function.
  activity_test <- inner_join(y_test, activity_labels) # Joining, by = "Activity.ID"
  
  # Merge all three dataframes in the final test dataset:
  data_test <- cbind(subject_test, X_test, activity_test)
  
  ### 1. Merge the test and training datasets:
  dataset <- rbind(data_train, data_test)
  
  ### 2. Extract only mean and standard deviation measurements:
  toMatch <- c("mean", "std")
  matches <- unique(grep(paste(toMatch, collapse="|"), names(dataset), value=TRUE))
  new_dataset <- dataset[, matches] # Columns will have only mean and std names
  # Add Participant ID and Activity Name to the dataframe as first and last columns respectively
  new_dataset <- cbind(Subject.ID = dataset$Subject.ID, Activity.Name = dataset$Activity.Name, dataset[, matches])
  
  ### 3. Uses descriptive activity names to name the activities in the data set
  # This was accomplished in lines 30 and 52 of the function when we joined the tables such that
  # we have a mapping between the activity number and activity name.
  
  ### 4. Appropriately labels the data set with descriptive variable names.
  # This was accomplied in lines 24 nd 46 of the function when we assigned new column names
  # to the dataframes.
  
  ### 5. From the data set in step 4, creates a second, independent tidy data set with the 
  ###    average of each variable for each activity and each subject.
  final_dataset <- tbl_df(new_dataset) # Use "dplyr" library to create a df
  group_finalDataset <- group_by(final_dataset, Subject.ID, Activity.Name) # group by Subject and Activity
  summarise_all(group_finalDataset, mean) # Summarise by caclulating the mean of each column for the groups
  
  #write.table(summarise_all(group_finalDataset, mean), file = "tidyData.txt", row.name=FALSE)
  
  ## To view the complete dataframe use View() function:
  # View(summarise_all(group_finalDataset, mean))
}