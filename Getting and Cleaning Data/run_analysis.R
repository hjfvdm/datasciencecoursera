library(plyr)

## Main function. This function will:
## 1.Load and add labels to the data set
## 2.Extract the relevant columns we're interested in
## 3.Summarise the data as required
## 4.Save the cleaned data to file
cleanAndSaveData <- function(){
        data <- combineAndAddLabels()
        subset <- extractRelevantColumns(data)
        
        ## summarise results
        summarisedData <- ddply(subset, .(activity, subject), numcolwise(mean))
       
        ## write summarised data to file
        write.table(subset, file="summarisedData.txt", sep = "\t", append=F)    
}

## This function loads the test and train data sets. It then adds more
## descriptive labels. Lastly it combines the two data sets into one
## returning the new data set
combineAndAddLabels <- function() {  
        
        ## load training files
        xTrain = read.table("./4/train/X_train.txt")
        yTrain = read.table("./4/train/y_train.txt")
        sTrain = read.table("./4/train/subject_train.txt")
        
        ## load testing files
        xTest = read.table("./4/test/X_test.txt")
        yTest = read.table("./4/test/y_test.txt")
        sTest = read.table("./4/test/subject_test.txt")
        
        ## load file headings
        headings = read.table("./4/features.txt")$V2
        
        ## load activities
        activities  = read.table("./4/activity_labels.txt")
        
        ## add heading names to data sets
        colnames(xTrain) = headings
        colnames(xTest) = headings
        
        ## rename V1 to activity
        yTest <- rename(yTest, c(V1="activity"))
        yTrain <- rename(yTrain, c(V1="activity"))
        
        ## add labels and convert to factors
        yTrain$activity = factor(yTrain$activity, labels = activities$V2)
        yTest$activity = factor(yTest$activity, labels = activities$V2)
        
        ## rename V1 variable to subject
        sTrain <- rename(sTrain, c(V1="subject"))
        sTest <- rename(sTest, c(V1="subject"))
        
        ## finally combine into one dataset
        rbind(cbind(xTrain, sTrain, yTrain), cbind(xTest, sTest, yTest))
}

## This function will grep through all the colums and only extract columns
## containing one of the following: id, activity, mean, std
extractRelevantColumns <- function(data){
        match = "subject|activity|mean|std"
        data[,grep(match , names(data), value=TRUE)]        
}
