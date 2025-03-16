# Load required libraries and initialize the script and setup: 
library(dplyr)     # For data manipulation
library(readr)     # For the write_tsv function
library(data.table) # For fast data loading
library(here)

# Clean title_ratings:

# Input
title_ratings <- fread(here("data", "title_ratings.tsv.gz"), sep = "\t", na.strings = "\\N")

# Transformation: 
if (!exists("title_ratings")) stop("Dataset 'title_ratings' not found.")

title_ratings <- title_ratings %>%
  mutate(
    averageRating = as.numeric(averageRating), 
    numVotes = as.numeric(numVotes)
  ) %>%
  filter(!is.na(averageRating) & !is.na(numVotes))

write_csv(title_ratings, here("data", "title_ratings_cleaned.csv"))
cat("Cleaning title ratings complete.\n")

# Clean title_basics:

# Load required libraries and initialize the script and setup: 
library(data.table) 
library(here)

# Input:
title_basics <- fread(here("data", "title_basics.tsv.gz"), sep = "\t", na.strings = "\\N")

# Transformation:
title_basics[, c("endYear", "originalTitle") := NULL]  # Remove unnecessary columns
title_basics <- title_basics[titleType %in% c("movie", "tvMovie")]
title_basics <- title_basics[startYear <= year(Sys.Date())]

cat("Rows before cleaning:", nrow(title_basics), "\n") # Display row count before filtering by year
current_year <- year(Sys.Date()) # Find the current year
title_basics <- title_basics %>% filter(startYear <= current_year) # Filter movies up to the current year
cat("Rows after cleaning basic title:", nrow(title_basics), "\n") # Display row count after filtering

# Save the cleaned data to a CSV file
write_csv(title_basics, here("data", "title_basics_cleaned.csv"))
cat("Cleaning title basics complete.\n")

