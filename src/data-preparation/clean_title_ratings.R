# Load required libraries and initialize the script and setup: 

library(dplyr)     # For data manipulation
library(readr)     # For the write_tsv function
library(data.table) # For fast data loading
library(here)

#Input
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