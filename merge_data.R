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

mergeFiles <- function()
{
    file_list_raw <- list.files("./data/UCI HAR Dataset/test")
    file_list <- file_list_raw[grepl("*\\.txt$", file_list_raw)]
    data_sets <- lapply(file_list, function(x) { read.table(paste("./data/UCI HAR Dataset/test/",x,sep = ""), sep = "" , stringsAsFactors= F) } )
    merged_sets <- Reduce(function(a, b) { merge(a, b, by=0, all=TRUE) }, data_sets)
    write.csv(merged_Sets, file="./data/merged.csv", row.names=FALSE)
}

mergeFiles()