# Initializing the script/setup:

install.packages(c("dplyr", 'R.utils', "lubridate")) # this one can be deleted since is already in download part.
library(data.table) 
library(R.utils)
library(tidyverse)
library(lubridate)

# Transformation:

title_basics[, endYear :=NULL] # Remove unnecessary columns
title_basics[, originalTitle :=NULL] # Remove unnecessary columns

title_basics <- title_basics %>% filter(titleType %in% c("movie", "tvMovie")) # Keep only movies and TV movies


cat("Rows before cleaning:", nrow(title_basics), "\n") # Display row count before filtering by year
current_year <- year(Sys.Date()) #Find the current year
title_basics <- title_basics %>% filter(startYear <= current_year) # Filter movies up to the current year
cat("Rows after cleaning:", nrow(title_basics), "\n") # Display row count after filtering
cat("Cleaning complete.\n")



# If you want to save the cleaned dataset as a new file.
# write_tsv(ratings_df_cleaned, file.path(tempdir(), "title.ratings_cleaned.tsv")) --> I feel the main idea of makefile is to not safe the file in the computer so I would do it
# cat("Cleaning complete. Cleaned dataset saved as 'title.ratings_cleaned.tsv'.\n") 

