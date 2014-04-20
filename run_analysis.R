#!/usr/bin/env Rscript
source("build_main_dataset.R")
source("group_data.R")

main_dataset <- buildDataset()
groupped <- groupData(main_dataset)
write.csv(groupped, file="./data/groupped.csv", row.names=FALSE)