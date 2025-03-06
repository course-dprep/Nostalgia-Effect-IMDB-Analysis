# Load required libraries and initialize the script and setup:
library(dplyr) 
library(data.table)
library(R.utils)
library(lubridate)
library(readr)

# Transformation

# Merge the datasets on 'tconst'
merged_df <- title_basics %>%
  full_join(title_ratings, by = "tconst")

# Add a new column to identify whether a title is released based on the presence of ratings
merged_df <- merged_df %>%
  mutate(isReleased = ifelse(!is.na(averageRating), "Released", "Unreleased"))

# Define the output file path in the specific folder
output_path <- file.path("~", "team-project-spring-2025-team-4", "data", "datasets", "merged_titles.tsv")

# Save the cleaned merged dataset to the specified folder
write_tsv(merged_df, output_path)

cat("Merged dataset saved as 'merged_titles.tsv' in '~/team-project-spring-2025-team-4/data/datasets'.\n")
cat("Total titles merged:", nrow(merged_df), "\n")

# View the merged dataset in RStudio
View(merged_df)
cat("Total number of observations:", nrow(merged_df), "\n")

