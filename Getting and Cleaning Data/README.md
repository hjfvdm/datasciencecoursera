# Getting and Cleaning Data #

This folder contains the following files:
 1. Folder (4) with raw data files for the project
 2. R script file: run_analysis.R
 3. The generated tidy data file: summarisedData.txt
 4. codebook for the tidy data file: codebook.txt

To run the script file, load it into your R environment (source('[<file location>/run_analysis.R')) and run the function: cleanAndSaveData()
This function will:
 1.Load and add labels to the data set
 2.Extract the relevant columns we're interested in
 3.Summarise the data as required
 4.Save the cleaned data to file (in your working directory). The file is called summarisedData.txt
