==================================================================
Getting and cleaning data course project
==================================================================

Purpose
-------

The R script run_analysis.R was created with the purpose of obtaining the Coursera certificate on 'Getting and Cleaning Data'. In broad terms the script aims at creating a tidy dataset, as described in the lecture video's, of the given data. These data consisted of 6 datastes, 3 related to the train set and 3 related to the test set. Apart from making the data tidy, the script also performs some other analysis, as required by the assignment. It for example also extract all the variable names of the tidy dataset that contain the word 'mean' or 'stddev'. Further also another dataset was extracted from the first created dataset.

script set-up
--------------

The script is divided into 5 subparts. Each corresponding to a certain part of the assigment:

1. Merge the test and train set: in this part  the 6 datasets are imported and merged together to obtain the merged dataset called 'dat'. Also it give appropriate label names there were necessary.
2. Extract only the measurements and mean and standard deviation for each measurement. This part extracts all columns for the dataset 'dat' that have information on the mean or standard deviation of a certain measure. This information is stored in a dataset called 'MeanStd'
3. Use descriptive label names: The values for the column 'activity', describing what kind of activity the observed person was undertaking are labeled with numbers from 1 to 6. As this is not informative these values are replaced with more informative labels like 'WALKING', 'WALKING_UPSTAIRS', etc.
4. Appropriately label dataset names: Here the label names are made more clear such that they only contain letters, numbers and dots.
5. Create second independently dataset. This part creates out of the dataset 'dat' a new tidy dataset with information on the mean of each activity, grouped per subject and activity.

Note that for running this script the library 'plyr' has to be installed first.
