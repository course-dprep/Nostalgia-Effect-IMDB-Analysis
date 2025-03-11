# Initializing the script/setup:


# Install and load necessary libraries
if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
if (!require("readr")) install.packages("readr", dependencies = TRUE)
if (!require("R.utils")) install.packages("R.utils", dependencies = TRUE)
if (!require("tidyverse")) install.packages("tidyverse", dependencies = TRUE)
if (!require("lubridate")) install.packages("lubridate", dependencies = TRUE)
if (!require("here")) install.packages("here", dependencies = TRUE)

library(data.table) # For fast data loading

# Download the files into the local data folder
download.file("https://datasets.imdbws.com/title.basics.tsv.gz", 
              destfile = here("data", "title_basics.tsv.gz")
)
download.file("https://datasets.imdbws.com/title.ratings.tsv.gz", 
              destfile = here("data", "title_ratings.tsv.gz")
)
cat("All dataset successfully downloaded and uploaded in data folder.\n") # Cleaning title basics complete