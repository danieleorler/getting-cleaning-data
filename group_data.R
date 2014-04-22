#####################################################################
# compute average of each variable grouping by activity and subject #
#####################################################################
groupData <- function(dataset)
{
    aggregate( dataset[,4:69], dataset[,1:3], FUN = mean )
}