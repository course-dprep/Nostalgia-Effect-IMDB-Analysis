# In this directory, you will keep all source code files relevant for 
# preparing/cleaning your data.

# Load required libraries
library(dplyr)
library(readr)
library(data.table)
library(lubridate)

# Load the datasets (assuming they are already in the 'datasets' list)
title_basics <- datasets$title.basics
title_ratings <- datasets$title.ratings

# Convert relevant columns to numeric for proper filtering and merging
title_basics <- title_basics %>%
  mutate(
    startYear = as.numeric(startYear),
    runtimeMinutes = as.numeric(runtimeMinutes)
  )

title_ratings <- title_ratings %>%
  mutate(
    averageRating = as.numeric(averageRating),
    numVotes = as.numeric(numVotes)
  )

# Filter out movies that are unreleased (startYear >= 2025)
title_basics <- title_basics %>%
  filter(!is.na(startYear) & startYear < 2025)

# Merge the datasets on 'tconst'
merged_df <- title_basics %>%
  left_join(title_ratings, by = "tconst")

# Identify potentially unreleased titles (no ratings available)
merged_df <- merged_df %>%
  mutate(isReleased = ifelse(!is.na(averageRating), "Released", "Unreleased"))

# Save the merged dataset as a TSV file
write_tsv(merged_df, "merged_titles.tsv")

# Save only the unreleased titles separately
unreleased_titles <- merged_df %>% filter(isReleased == "Unreleased")
write_tsv(unreleased_titles, "unreleased_titles.tsv")

# Summary output
cat("✅ Merged dataset saved as 'merged_titles.tsv'.\n")
cat("✅ Unreleased titles saved as 'unreleased_titles.tsv'.\n")
cat("📊 Total titles merged:", nrow(merged_df), "\n")
cat("📌 Potential unreleased titles:", nrow(unreleased_titles), "\n")

# Display the first few rows of the merged dataset for verification
head(merged_df)

View(merged_df)
