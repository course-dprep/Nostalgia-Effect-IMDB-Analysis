# Load required libraries and initialize the script and setup
library(dplyr) 
library(data.table)
library(readr)
library(here)

#Input: Load pre-cleaned title_basics and title_ratings datasets
title_basics <- read.csv(here("data", "title_basics_cleaned.csv"))
title_ratings <- read.csv(here("data", "title_ratings_cleaned.csv"))

# Transformation: Merge the datasets on 'tconst'
data_merging <- title_basics %>%
  full_join(title_ratings, by = "tconst") %>%
  mutate(isReleased = ifelse(!is.na(averageRating), "Released", "Unreleased"))

# Output: save merged dataset into a csv file
write_csv(data_merging, here("data", "final_merged.csv"))
cat("Merged dataset saved.\n")