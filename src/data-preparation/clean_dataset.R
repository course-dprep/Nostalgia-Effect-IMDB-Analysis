# Load required libraries and initialize the script and setup
library(dplyr)     
library(readr)    
library(data.table) 
library(here)

# Title ratings dataset
# Input: Load the IMDb title ratings dataset
title_ratings <- fread(here("data", "title_ratings.tsv.gz"), sep = "\t", na.strings = "\\N")

# Transformation: clean and filter datasets
if (!exists("title_ratings")) stop("Dataset 'title_ratings' not found.")

title_ratings <- title_ratings %>%
  mutate(
    averageRating = as.numeric(averageRating), 
    numVotes = as.numeric(numVotes)
  ) %>%
  filter(!is.na(averageRating) & !is.na(numVotes))

# Output: saved cleaned files into a csv file
write_csv(title_ratings, here("data", "title_ratings_cleaned.csv"))
cat("Cleaning title ratings complete.\n")

# Title basics dataset
# Input: Load the IMDb title basics dataset
title_basics <- fread(here("data", "title_basics.tsv.gz"), sep = "\t", na.strings = "\\N")

# Transformation: clean and filter datasets
# Remove unnecessary columns
title_basics[, c("endYear", "originalTitle") := NULL]  
title_basics <- title_basics[titleType %in% c("movie", "tvMovie")]

# Display row count before filtering by year
cat("Rows before cleaning:", nrow(title_basics), "\n") 
# Find the current year
current_year <- year(Sys.Date()) 
# Filter movies up to the current year
title_basics <- title_basics %>% filter(startYear <= current_year) 
# Filter movies which the start year is at least 1980
title_basics <- title_basics %>% filter(startYear >= 1980) 
# Display row count after filtering
cat("Rows after cleaning basic title:", nrow(title_basics), "\n") 

# Output: saved cleaned dataset into a csv File
write_csv(title_basics, here("data", "title_basics_cleaned.csv"))
cat("Cleaning title basics complete.\n")