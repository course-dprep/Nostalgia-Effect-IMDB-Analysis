# Load required libraries and initialize the script and setup: 

library(dplyr) 
library(data.table)
library(R.utils)
library(lubridate)
library(readr)

# Transformation 

merged_df <- title_basics %>%
  full_join(title_ratings, by = "tconst") # Merge datasets on 'tconst'

merged_df <- merged_df %>%
  mutate(isReleased = ifelse(!is.na(averageRating), "Released", "Unreleased")) # Identify potentially unreleased titles (no ratings available)

write_tsv(merged_df, "merged_titles.tsv") # Save the cleaned merged dataset

cat("Merged dataset saved as 'merged_titles.tsv'.\n")
cat("Unreleased titles saved as 'unreleased_titles.tsv'.\n")
cat(" Total titles merged:", nrow(merged_df), "\n") # Display results

View(merged_df)
cat("Total number of observations:", nrow(merged_df), "\n") # Verify dataset visually in RStudio

