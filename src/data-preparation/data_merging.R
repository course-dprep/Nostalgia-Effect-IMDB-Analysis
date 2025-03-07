# Load required libraries and initialize the script and setup:
library(dplyr) 
library(data.table)
library(R.utils)
library(lubridate)
library(readr)

#Input:
title_basics <- read.csv("../../data/title_basics_cleaned.csv")
title_ratings <- read.csv("../../data/title_ratings_cleaned.csv")

# Transformation

# Merge the datasets on 'tconst'
data_merging <- title_basics %>%
  full_join(title_ratings, by = "tconst")

# Add a new column to identify whether a title is released based on the presence of ratings
data_merging <- data_merging %>%
  mutate(isReleased = ifelse(!is.na(averageRating), "Released", "Unreleased"))

# Save the merged data to a CSV file
write_csv(data_merging,file = "../../data/final_merged.csv")

cat("Merged dataset saved as 'final_merged.csv'.\n")
cat("Total titles merged:", nrow(data_merging), "\n")

# View the merged dataset in RStudio
View(data_merging)
cat("Total number of observationsa after merging:", nrow(data_merging), "\n")

