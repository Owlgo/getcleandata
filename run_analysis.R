## week 3 project asignment
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
> setwd("C:\\markstuff\\markstuff\\coursera\\getcleandat\\week3\\data\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset")

#
library(plyr)
## 1.     Merges the training and the test sets to create one data set.
#
        trngSet <- read.table("X_train.txt")
 ##       trngNam <- paste("trng",names(trngSet),sep="")
 ##       colnames(trngSet)<-trngNam
        tstSet <- read.table("X_test.txt")
 ##       tstNam <- paste("tst",names(tstSet),sep="")
 ##       colnames(tstSet)<-tstNam
        oneDataSet <- merge(trngSet, tstSet, all=TRUE)
#        
        feat<-read.table("features.txt")
        feat <- data.frame(lapply(feat, as.character), stringsAsFactors=FALSE)
#
        colnames(oneDataSet)<-feat$V2
        names(oneDataSet)<-make.names(names(oneDataSet),unique=TRUE) ## make names R;replace bad characters
                                                                     ## w/ periods.
## 2.     Extracts only the measurements on the mean and standard deviation for each measurement. 
        g1<-oneDataSet[,grepl("mean", names(oneDataSet))]
        g2<-oneDataSet[,grepl("std", names(oneDataSet))]
## 3.     Uses descriptive activity names to name the activities in the data set
        ytst<-read.table("y_test.txt")
        ytrn<-read.table("y_train.txt")
        subtrn<-read.table("subject_train.txt")
        subtst<-read.table("subject_test.txt")
        act<-append(ytrn$V1,ytst$V1, after=length(ytrn$V1))
        subj<-append(subtrn$V1,subtst$V1, after=length(subtrn$V1))

revalue(act$V1, c(a = "A", c = "C"))
        oneDataSet["activity"] <- NA 
        oneDataSet["subject"]<-NA
        oneDataSet$activity <- act
        oneDataSet$subject<-subj
#
## 4.     Appropriately labels the data set with descriptive variable names.
        oneDataSet$activity[oneDataSet$activity == "1"] <-"WALKING"
        oneDataSet$activity[oneDataSet$activity == "2"] <-"WALKING_UPSTAIRS"
        oneDataSet$activity[oneDataSet$activity == "3"] <-"WALKING_DOWNSTAIRS"
        oneDataSet$activity[oneDataSet$activity == "4"] <-"SITTING"
        oneDataSet$activity[oneDataSet$activity == "5"] <-"STANDING"
        oneDataSet$activity[oneDataSet$activity == "6"] <-"LAYING"
oneDataSet$subject<-as.factor(oneDataset$subj)
## 5.     From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
lapply(split(oneDataSet$tBodyAcc.mean...X,oneDataSet$activity),mean, na.rm=TRUE)
lapply(split(oneDataSet$tBodyAcc.mean...X,oneDataSet$subject),mean, na.rm=TRUE)
