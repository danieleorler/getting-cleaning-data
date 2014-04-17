#!/usr/bin/env Rscript

#####################################
#  create dir if it doesn't exists  #
#####################################
createDir <- function()
{
    if(!file.exists("data"))
    {
        dir.create("data")
    }
}

#######################################
#  download and unzip data in ./data  #
#######################################
getData <-function()
{
    createDir()
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    fileDest <- "./data/dataset.zip"
    # download the source file into the destination file
    download.file(fileUrl,destfile=fileDest, method="wget")
    # unzip the downloaded file
    unzip(fileDest, exdir="./data")
    # remove the zip archive
    file.remove(fileDest)
}

mergeFolderFile <- function(folder)
{
    # get path to folder
    path <- paste("./data/UCI HAR Dataset/",folder,"/",sep="")
    # list all files inside the folder
    file_list_raw <- list.files(path)
    # keep only *.txt files
    file_list <- file_list_raw[grepl("*\\.txt$", file_list_raw)]
    # load files data
    data_sets <- lapply(file_list, function(x) { read.table(paste(path,x,sep = ""), sep = "" , stringsAsFactors= F) } )
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

mergeTrainAndTest <- function()
{
    # merge test files
    test_data <- mergeFolderFile("test")
    # merge train files
    train_data <- mergeFolderFile("train")
    # append train rows to test rows
    all_together <- rbind(test_data,train_data)
    # write the resulting data.frame to csv
    write.csv(all_together, file="./data/merged.csv", row.names=FALSE)
}

mergeTrainAndTest()