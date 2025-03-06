# Load required libraries and initialize the script and setup: 

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
cat("Cleaning title basics complete.\n") # Cleaning title basics complete




