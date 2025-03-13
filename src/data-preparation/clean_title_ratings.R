# Load required libraries and initialize the script and setup: 

library(dplyr)     # For data manipulation
library(readr)     # For the write_tsv function
library(data.table) # For fast data loading
library(here)

#Input:
title_ratings <- fread("../../data/title_ratings.tsv.gz", sep = "\t", na.strings = "\\N")# Now load the datasets from the local files

# Transformation: 

if (!exists("title_ratings")) {
  stop("Dataset 'title_ratings' not found. Make sure it is loaded correctly.")
} # Check if the 'title_ratings' dataset exists

cat("Number of rows before cleaning:", nrow(title_ratings), "\n") # Display the number of rows before cleaning

title_ratings <- title_ratings %>%
  mutate(
    averageRating = as.numeric(averageRating), # Convert the 'averageRating' and remove rows with NA values
    numVotes = as.numeric(numVotes) # Convert 'numVotes' columns to numeric and remove rows with NA values
  ) %>%
  filter(!is.na(averageRating) & !is.na(numVotes))  
# Save the cleaned data to a CSV file
write_csv(title_ratings, file = here("data", "title_ratings_cleaned.csv"))

cat("Number of rows after cleaning title ratings:", nrow(title_ratings), "\n") # Display the number of rows after cleaning
cat("Cleaning title ratings complete.\n") # Cleaning title ratings complete

