# Initializing the script/setup:

# Install and load necessary libraries
if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
if (!require("readr")) install.packages("readr", dependencies = TRUE)
if (!require("R.utils")) install.packages("R.utils", dependencies = TRUE)

library(data.table) # For fast data loading

# Input:
title_basics <- fread("https://datasets.imdbws.com/title.basics.tsv.gz", sep = "\t", na.strings ="\\N") 
title_ratings <- fread("https://datasets.imdbws.com/title.ratings.tsv.gz", sep = "\t", na.strings ="\\N") # Download and load IMDb datasets

if (is.null(title_basics) | is.null(title_ratings)) {
  stop("One or more datasets failed to load. Check your internet connection or dataset URLs.")
} else {
  cat("All datasets successfully downloaded and loaded.\n")} # Check data integrity --> is it necessary?

# K comment: is it all, it looks to short now, but I wouldn't save it as a new file since we don't want to occupy space in the computer (that's why we use make)
# and since we just need to download the file idk what else to do.
