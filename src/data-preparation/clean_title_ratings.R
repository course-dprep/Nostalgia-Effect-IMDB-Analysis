# Load required libraries and initialize the script and setup: 

library(dplyr)     # For data manipulation
library(readr)     # For the write_tsv function

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

cat("Number of rows after cleaning:", nrow(title_ratings), "\n") # Display the number of rows after cleaning
cat("Cleaning title ratings complete.\n") # Cleaning title ratings complete

