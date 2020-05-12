library(dplyr)

# Loading variables and activities names -------------------------------------------------

filename <- "features.txt"
features <- read.table(filename)
features <- drop(features[2])

filename <- "activity_labels.txt"
activity_lbl <- read.table(filename, col.names = c("id", "label"))


# Load and join data ---------------------------------------------------------------

#Load X_train data 
filename <- "X_train.txt"
x <- read.table(filename, col.names = t(features))
#Select columns that contain mean or standard deviation
x<-x %>% select(grep('mean\\.|std', names(x)))

#Load y_train data
filename <- "y_train.txt"
y <- read.table(filename, col.names = c("activity"))
#Replace activity with descruptive name
y[, 1] <- activity_lbl[y[, 1], 2]

#Load subject_train data
filename <- "subject_train.txt"
subject <- read.table(filename, col.names = c("subject"))

#Join x,y,activity and subject data into train dataset
train<-cbind(subject, y, x)

#Repeate steps above for test data
filename <- "X_test.txt"
x <- read.table(filename, col.names = t(features))
x<-x %>% select(grep('mean\\.|std', names(x)))

filename <- "y_test.txt"
y <- read.table(filename, col.names = c("activity"))
y[, 1] <- activity_lbl[y[, 1], 2]

filename <- "subject_test.txt"
subject <- read.table(filename, col.names = c("subject"))

test<-cbind(subject, y, x)


# Join train and test datasets --------------------------------------------

df<-bind_rows(train,test)

#Delete unused data
remove(train,test,x,y,subject,activity_lbl,features,filename)

#Remove extra dots in column names
colnames(df) <- gsub('\\.\\.','',names(df))
df$subject <- as.factor(df$subject)


# Create dataset that contains average values for each subject and --------

df_average <- df %>% 
    group_by(subject,activity) %>% 
    summarise_each(funs(mean))

#Write this dataset to .txt file
write.table(df_average, "averagedata.txt", row.names = FALSE)
