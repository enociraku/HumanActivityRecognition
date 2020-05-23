##### run_analysis()

The run_analysis() function takes the data from the UCI HAR Dataset and transforms it in a clean format based on the requirements of the assignment. This document will explain the step by step workings of the run_analysis.R file which contains this function.

# Step 0:
Create/Save the run_analysis.R file at the same folder in which you have your dataset.
We will need to join tables with each other and also do summary statistics, so we need to load the *"dplyr"* library as a first step before starting to write any line of code:
`library("dplyr")`

We are going to work with the following files:
  - *features.txt, activity_labels.txt*
  - *subject_train.txt, X_train.txt, y_train.txt* (inside the **train** folder)
  - *subject_test.txt, X_test.txt, y_test.txt* (inside the **test** folder)

Take a look at the CodeBook.md file for a description of the dataset.

# Step 1:
As a first step we will need to load the data in the R environment. Our data are stored in *.txt* files so we use the `read.table()` function and store them in an appropriately named dataframe:
`features <- read.table("features.txt")`
`activity_labels <- read.table("activity_labels.txt")`
The read.table() function gives standard names to the columns of the dataframe; "V1" for first column, "V2" for second column, etc. In order to make sense of the data we have to give them meaningful names. This is accomplished by the following lines:
`names(features) <- c("Feature.ID", "Feature.Name")`
`names(activity_labels) <- c("Activity.ID", "Activity.Name")`

# Step 2a:
Now we will load and format our **train** dataset. First we will load the corresponding three *.txt* files and then we will change the column names:\
`train_path <- "train/"`
`subject_train <- read.table(paste(train_path, "subject_train.txt", sep = ""))`  
`X_train <- read.table(paste(train_path, "X_train.txt", sep = ""))`
`y_train <- read.table(paste(train_path, "y_train.txt", sep = ""))`
The `train_path` variable may be changed according to your own location of the train folder with respect to the *run_analysis.R* file.
After loading the files in their respective dataframes we can chnage their column names:
`names(subject_train) <- "Subject.ID"`
`names(X_train) <- features$Feature.Name`
`names(y_train) <- "Activity.ID"`

# Step 2b:
The *y_train.txt* file contains integers from 1 to 6 which correspond to the encoding of the activity labels. In order to make our data more meaningfull we will create the mapping between the numbers and labels of the activities. This will be done by using the inner_join() function of the "dplyr" library. We will join by "Activity.ID" column.
`activity_train <- inner_join(y_train, activity_labels)`

To complete our train dataset we will stack together this newly created dataframe with subject_train (which contains the ID of the participants) and X_train (which contains the measurements).
`data_train <- cbind(subject_train, X_train, activity_train)`

# Step 3:
The same identical procedure will be done for the test dataset, hence I will only provide the code. The explanation is identical to the Step 2a and Step 2b.
First load the dataset in R:
`test_path <- "test/"`
`subject_test <- read.table(paste(test_path, "subject_test.txt", sep = ""))`
`X_test <- read.table(paste(test_path, "X_test.txt", sep = ""))`
`y_test <- read.table(paste(test_path, "y_test.txt", sep = ""))`
Change the default column names:
`names(subject_test) <- "Subject.ID"`
`names(X_test) <- features$Feature.Name`
`names(y_test) <- "Activity.ID"`

Create the same mapping between activity number and label:
`activity_test <- inner_join(y_test, activity_labels)`

Stack the three dataframes columns-wise:
`data_test <- cbind(subject_test, X_test, activity_test)`

# Step 4:
Now we merge the train and test datasets in one single dataset (in this case the merging will be row-wise, so they will be stacked one above the other):
`dataset <- rbind(data_train, data_test)`

# Step 5:
Now this next step involves extracting only measurements which include values of either the mean or standard deviation. We will approach this problem as follows:
First we create a vector with the names (or partial names) of the columns which we want to extract. The mean measurements include the name "...mean..." in their columns while the standard deviation measurements include the "..std..." name.
`toMatch <- c("mean", "std")`
We want to find all occurences of these names in our dataset columns. We search for the names with the grep() command.
`matches <- unique(grep(paste(toMatch, collapse="|"), names(dataset), value=TRUE))`
(`value = TRUE` will return the actual names and not the index of the occurrence)
Now that we have the names of the columns it is time to create the new dataframe with just these column names:
`new_dataset <- dataset[, matches]` 
This dataset will contain just column names that are either mean or std. We will need to add the two columns "Participant.ID" and "Activity.Name" to complete the dataset:
`new_dataset <- cbind(Subject.ID = dataset$Subject.ID, Activity.Name = dataset$Activity.Name, dataset[, matches])`

# Step 6:
The final step will be to perform summary statistics. In this assignment we are required to take the mean of each column based on Activity and Participant.
First we create a "tidy" dataframe since we will need to use specific functions (such as group_by()).
`final_dataset <- tbl_df(new_dataset)`
Next we group the data based on Activity and Participant:
`group_finalDataset <- group_by(final_dataset, Subject.ID, Activity.Name)`
Now we will perform summary statistic on all the columns based on these groups:
`summarise_all(group_finalDataset, mean)`

This will be the final dataset with mean measurements of the specified columns. To view the complete dataset you can use the following line:
`View(summarise_all(group_finalDataset, mean))`
And to write the dataset in a file use:
`write.table(summarise_all(group_finalDataset, mean), file = "tidyData.txt", row.name=FALSE)`
