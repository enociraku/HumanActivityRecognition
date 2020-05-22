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
Now we will load and format our **train** dataset. First we will load the corresponding three *.txt* files and then we will change the column names:
`train_path <- "train/"`
`subject_train <- read.table(paste(train_path, "subject_train.txt", sep = ""))`
`X_train <- read.table(paste(train_path, "X_train.txt", sep = ""))`
`y_train <- read.table(paste(train_path, "y_train.txt", sep = ""))`
The `train_path` variable may be changed according the your own location of the train folder with respect to the *run_analysis.R* file.
After loading the files in their respective dataframes we can chnage their column names:
`names(subject_train) <- "Subject.ID"`
`names(X_train) <- features$Feature.Name`
`names(y_train) <- "Activity.ID"`

# Step 2b:
