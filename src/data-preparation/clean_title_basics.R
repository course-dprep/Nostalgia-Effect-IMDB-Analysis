# Load required libraries and initialize the script and setup: 

library(data.table) 
library(R.utils)
library(tidyverse)
library(lubridate)
library(here)

#Input:
title_basics <- fread("../../data/title_basics.tsv.gz", sep = "\t", na.strings = "\\N")# Now load the datasets from the local files

# Transformation:
title_basics[, endYear :=NULL] # Remove unnecessary columns
title_basics[, originalTitle :=NULL] # Remove unnecessary columns

title_basics <- title_basics %>% filter(titleType %in% c("movie", "tvMovie")) # Keep only movies and TV movies


cat("Rows before cleaning:", nrow(title_basics), "\n") # Display row count before filtering by year
current_year <- year(Sys.Date()) #Find the current year
title_basics <- title_basics %>% filter(startYear <= current_year) # Filter movies up to the current year
cat("Rows after cleaning basic title:", nrow(title_basics), "\n") # Display row count after filtering
# Save the cleaned data to a CSV file
write_csv(title_basics, file = here("data", "title_basics_cleaned.csv"))

cat("Cleaning title basics complete.\n") # Cleaning title basics complete