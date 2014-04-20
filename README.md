# How to run the scripts #
Once the scripts are checked out on your computer, the first think to do in fetching the data from the web.
To do so launch
```shell
    Rscript collect_data.R
```
from the folder where the scripts are placed.
This script will download the dataset from the web and will unzip it into the folder data/.

Now that all the datasets are in place you are ready to launch
```shell
    Rscript run_analysis.R
```
which will produce two CSV files inside the data/ folder
1. merged.csv (which is the file containing the main dataset)
2. groupped.csv (which is the file containing the aggregated data as in point 5 of assignment)