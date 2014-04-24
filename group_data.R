#####################################################################
# compute average of each variable grouping by activity and subject #
#####################################################################
groupData <- function(dataset)
{
    aggregate( dataset[,3:68], dataset[,1:2], FUN = mean )
}