# Load required libraries
library(dplyr)     # For data manipulation
library(readr)     # For the write_tsv function

# Check if the 'title_ratings' dataset exists
if (!exists("title_ratings")) {
  stop("Dataset 'title_ratings' not found. Make sure it is loaded correctly.")
}

# Display the number of rows before cleaning
cat("Number of rows before cleaning:", nrow(title_ratings), "\n")

# Convert the 'averageRating' and 'numVotes' columns to numeric and remove rows with NA values
title_ratings <- title_ratings %>%
  mutate(
    averageRating = as.numeric(averageRating),
    numVotes = as.numeric(numVotes)
  ) %>%
  filter(!is.na(averageRating) & !is.na(numVotes))

# Display the number of rows after cleaning
cat("Number of rows after cleaning:", nrow(title_ratings), "\n")
cat("Cleaning complete.\n")

