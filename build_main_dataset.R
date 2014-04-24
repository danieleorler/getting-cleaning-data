
#########################################
#  merge all the .txt files in a folder #
#########################################
mergeFolderFile <- function(folder)
{
    # get path to folder
    path <- paste("./data/UCI HAR Dataset/",folder,"/",sep="")
    # list all files inside the folder
    file_list_raw <- list.files(path)
    # keep only *.txt files
    file_list <- file_list_raw[grepl("*\\.txt$", file_list_raw)]
    # load files data
    data_sets <- lapply(file_list, function(x) { read.table(paste(path,x,sep = ""), sep = "" , stringsAsFactors=FALSE) } )
    # merge files data
    merged_sets <- Reduce(function(a, b)
    {
        tmp <- merge(a, b, by=0, all=TRUE)
        row.names(tmp) <- tmp[,"Row.names"]
        tmp[,!names(tmp) %in% "Row.names"]
    }, data_sets)
    # return resulting data.frame
    merged_sets
}

############################################
#      load and transpose data header      #
############################################
getHeader <- function()
{
    # load header
    header <- read.table("./data/UCI HAR Dataset/features.txt", sep = "" , stringsAsFactors=FALSE)
    # add an empty row to shift the transposed vector
    header <- rbind(c("subject()"),header)
    # transpose the header vector to make it a row
    header <- t(header[,2:ncol(header)])
    header
}

###################################################
#      extract the columns we want to remove      #
###################################################
getColumnsToRemove <- function()
{
    header <- getHeader()
    header <- header[1,]
    filtered <- header[-grep("(std|mean|subject)\\()", header)]
    filtered
}

###############################################
# add the hader to the dataset (column names) #
###############################################
setHeader <- function(dataset)
{
    header <- getHeader()
    colnames(dataset) <- header[1,]
    actual_header <- colnames(dataset)
    actual_header[is.na(actual_header)] <- "activity_id"
    colnames(dataset) <- actual_header
    dataset
}

############################################################
# join the main dataset with corresponding activity labels #
############################################################
joinActivityNames <- function(dataset)
{
    # load activity names
    activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", sep = "" , stringsAsFactors=FALSE)
    # join the main dataset with corresponding activity labels
    dataset <- merge(dataset,activity_labels,by.x="activity_id",by.y="V1")
    # rename activity label
    colnames(dataset)[colnames(dataset)=="V2"] <- "activity_description"
    dataset
}

############################################
#  append and write to a .csv all the data #
############################################
buildDataset <- function()
{
    # merge test files
    test_data <- mergeFolderFile("test")
    # merge train files
    train_data <- mergeFolderFile("train")
    # append train rows to test rows
    all_together <- rbind(test_data,train_data)
    # add header
    all_together <- setHeader(all_together)
    # take only meaningful columns
    final_dataset <- all_together[ , -which(names(all_together) %in% getColumnsToRemove())]
    # join activity labels
    final_dataset <- joinActivityNames(final_dataset)
    # moves activity_label column at the beggining
    col_idx <- grep("activity_description", names(final_dataset))
    final_dataset <- final_dataset[, c(col_idx, (1:ncol(final_dataset))[-col_idx])]
    # removes the activity_id column
    final_dataset$activity_id <- NULL
    # write the resulting data.frame to csv
    write.csv(final_dataset, file="./data/merged.csv", row.names=FALSE)
    # returns dataset
    final_dataset
}