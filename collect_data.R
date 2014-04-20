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

getData()