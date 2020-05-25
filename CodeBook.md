# Human Activity Recognition Using Smartphones Data Set

## Data Collection
The dataset is part of an experimental work to determine human activity based on measurements of sensor values.
The experiment containes 30 individuals (subjects), with an age bracket 19-48 years, and each person carried a smartphone on the waist. Using the smartphone's embedded accelerometer and gyroscope measurements of 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were taken. In total there were 561 measurements, with time and frequency domain variables, taken for each individual per activity performed. 
The activities performed were 6: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

## Dataset description
The dataset has the following relevant files:
- 4 text files: *features_info.txt*, *features.txt*, *activity_labels.txt*, *README.txt*
- 2 folders: **train**, **test**

*features_info.txt*: Shows information about the variables used on the feature vector.
*features.txt*: List of all features.
*activity_labels.txt*: Links the class labels with their activity name.
*README.txt* Provides general information about the dataset.


The **train** folder contains:
- **Inertial Signals** folder
- *subject_train.txt*
- *X_train*
- *y_train*  <br />  
The **Inertial Signals** contains raw measurements which are not used in our tidy data assignment.  
*subject_train.txt* contains the encoded ID of every participant. So, it is just a list of integers from 1 to 30.   
*X_train.txt* contains the measurements from the sensors. There 561 different variables for each activity performed.  
*y_train.txt* contains the resulting activity, which are encoded with numbers from 1 to 6 according to *activity_labels.txt*.

The **test** folder contains:
- **Inertial Signals** folder
- *subject_test.txt*
- *X_test*
- *y_test*  <br />  
The **Inertial Signals** contains raw measurements which are not used in our tidy data assignment.  
*subject_test.txt* contains the encoded ID of every participant. So, it is just a list of integers from 1 to 30.   
*X_test.txt* contains the measurements from the sensors. There 561 different variables for each activity performed.  
*y_test.txt* contains the resulting activity, which are encoded with numbers from 1 to 6 according to *activity_labels.txt*.
