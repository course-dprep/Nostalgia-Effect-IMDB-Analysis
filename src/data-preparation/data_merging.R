# In this directory, you will keep all source code files relevant for 
# preparing/cleaning your data.

# Load necessary libraries
# install.packages(c("dplyr", "data.table", "R.utils", "lubridate", "readr"))
library(dplyr)
library(data.table)
library(R.utils)
library(lubridate)
library(readr)

# Merge datasets on 'tconst'
merged_df <- title_basics %>%
  full_join(title_ratings, by = "tconst")

# Identify potentially unreleased titles (no ratings available)
merged_df <- merged_df %>%
  mutate(isReleased = ifelse(!is.na(averageRating), "Released", "Unreleased"))

# Save the cleaned merged dataset
write_tsv(merged_df, "merged_titles.tsv")

# Save only the unreleased titles separately
unreleased_titles <- merged_df %>% filter(isReleased == "Unreleased")
write_tsv(unreleased_titles, "unreleased_titles.tsv")

# Display results
cat("Merged dataset saved as 'merged_titles.tsv'.\n")
cat("Unreleased titles saved as 'unreleased_titles.tsv'.\n")
cat(" Total titles merged:", nrow(merged_df), "\n")
cat(" Potential unreleased titles:", nrow(unreleased_titles), "\n")

# Verify dataset visually in RStudio
View(merged_df)

cat("Total number of observations:", nrow(merged_df), "\n")

