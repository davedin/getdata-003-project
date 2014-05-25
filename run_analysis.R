### IMPORTANT ##################################
# set this the working directory for your system
################################################
wd = "C:/www/r/assignment-c3wk3/UCI HAR Dataset/"
setwd(wd)
getwd()


# 1. Load training and test data
###############################

## TRAINING DATA
# load training data
dataTrainX <- read.table("train/X_train.txt")
dataTrainY <- read.table("train/y_train.txt")
dataTrainSubject <- read.table("train/subject_train.txt")

# name training subject and activity data
colnames(dataTrainSubject) <- c("subject")
colnames(dataTrainSubject)
colnames(dataTrainY) <- c("activity")
colnames(dataTrainY)

## TEST DATA
# load testing data
dataTestX <- read.table("test/X_test.txt")
dataTestY <- read.table("test/y_test.txt")
dataTestSubject <- read.table("test/subject_test.txt")


# 2. Assign column names to the data sets
#########################################

# name test subject data
colnames(dataTestSubject) <- c("subject")
colnames(dataTestSubject)

# name test activity data
colnames(dataTestY) <- c("activity")
colnames(dataTestY)

# load feature/variable name
features <- read.table("features.txt")

# name columns of training and testing X files with feature names
colnames(dataTrainX) <- features[,2]
colnames(dataTestX) <- features[,2]


# 3. Combine test and traing data sets in into one data set
###########################################################

# combine test and traing data sets
allData    <- rbind(dataTrainX, dataTestX)
allSubject <- rbind(dataTrainSubject, dataTestSubject)
allY       <- rbind(dataTrainY, dataTestY)

dataAll <- cbind(allData, allSubject, allY)

# 4. Extract columns that contatin only mean and standard dev
#############################################################

allColNames <- colnames(dataAll)
    
subsetMeanColNames <- grep("mean", allColNames)
subsetStdColNames <- grep("std", allColNames) 
subsetMeanStdColNamesOrdered <- sort( c(subsetMeanColNames, subsetStdColNames, 562,563) )

dataFinal <- dataAll[,subsetMeanStdColNamesOrdered]

# 5. Label activies by using activity names instead of numbers
#############################################################

# label activites

unique(dataFinal$activity)

dataFinal$activity[dataFinal$activity == "1"] <- "WALKING"
dataFinal$activity[dataFinal$activity == "2"] <- "WALKING_UPSTAIRS"
dataFinal$activity[dataFinal$activity == "3"] <- "WALKING_DOWNSTAIRS"
dataFinal$activity[dataFinal$activity == "4"] <- "SITTING"
dataFinal$activity[dataFinal$activity == "5"] <- "STANDING"
dataFinal$activity[dataFinal$activity == "6"] <- "LAYING"


# 6. transform the column names to be more readable
#############################################################

# rename columns
names(dataFinal) <- gsub("tBody", "Time-Body", names(dataFinal))
names(dataFinal) <- gsub("fBody", "FFT-", names(dataFinal))
names(dataFinal) <- gsub("tGravity", "Time-Gravity", names(dataFinal))
names(dataFinal) <- gsub("-", ".", names(dataFinal))
names(dataFinal) <- tolower( names(dataFinal) )
names(dataFinal) <- gsub("\\(", "", names(dataFinal))
names(dataFinal) <- gsub(")", "", names(dataFinal))
names(dataFinal)


# 7. write the dataset to a file
#############################################################
write.table(dataFinal, "output.txt", sep = "\t", row.names = FALSE)


# 8. Creates a second data set with the average of each variable for each activity and each subject
###################################################################################################

# get the average of stuff
library("reshape2")

dataPrep <- dataFinal

# # make one column that combines the subjet and activity
# dataPrep$subject.activity <- do.call(paste, c(dataPrep[c("subject","activity")], sep = "_"))

# 8. Creates a second data set with the average of each variable for each activity and each subject
###################################################################################################

# 8.1 Get column names with numeric values
dataSummaryColNames <- colnames(dataPrep)
dataSummaryMeanColNames <- grep("mean", dataSummaryColNames)
dataSummaryStdColNames <- grep("std", dataSummaryColNames) 
dataSummarysubsetMeanStdColNamesOrdered <- sort( c(dataSummaryMeanColNames, dataSummaryStdColNames) )


# 8.2 melt the data to group by subject and activity
dataSummary <- melt(dataPrep, 
                    id=c("subject","activity"),
                    measure.vars=( dataSummarysubsetMeanStdColNamesOrdered ) # alternative: measure.vars=( 1:79 )                    
)

# head(dataSummary)
# tail(dataSummary)
# dcast(dataSummary, subject.activity ~ variable,mean), se

# 8.3 write get the mean the data for each variable grouped by subject and activity
tidyData <- dcast(dataSummary, subject + activity ~ variable, fun.aggregate=mean)
# tidyData
# head(tidyData, n=31)

# 8.4 write out the file of summarized data
write.table(tidyData, "tidyData.txt", sep = "\t", row.names = FALSE)
























# transform data so that each subject/activity
dataSummary <- melt(dataPrep, 
             id=c("subject.activity"),
             
           #  measure.vars=( c("time.bodyacc.mean.x") )
           measure.vars=( colnames( dataSummarysubsetMeanStdColNamesOrdered ) )
           
            )
head(dataSummary)
tail(dataSummary)

# dataSummary[dataSummary$variable == "time.bodyacc.mean.x"]
# dataSummary[dataSummary$variable == "time.bodyacc.mean.x" & dataSummary$subject.activity == "1_STANDING"]
# measubset(dataSummary, dataSummary$variable == "time.bodyacc.mean.x" & dataSummary$subject.activity == "1_STANDING", select = "value"))

bar <- dcast(dataSummary, subject.activity ~ variable,mean)
#bar <- dcast(dataSummary, subject.activity ~ value,mean)
#bar<- tapply(foo$value, foo$subject.activity, mean(na.rm=T))
head(bar, n=301)
str(bar)
