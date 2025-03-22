# Load required libraries and initialize the script and setup
library(tidyr)
library(dplyr) 
library(readr)
library(here)

# Input:# Load the previously merged IMDb dataset
data_merging <- read_csv(here("data", "final_merged.csv"))

# Print the total rows before cleaning
cat("Total rows before cleaning:", nrow(data_merging), "\n")

# Transformation: clean Data, remove outliers, filter genres
# Clean the dataset by removing rows with NA values
merged_df_clean <- data_merging %>%
  drop_na() # Remove rows with NA values

# Compute outlier bounds for averageRating⁠ using the IQR rule and remove outliers
stats <- merged_df_clean %>%
  summarize(
    Q1 = quantile(averageRating, 0.25, na.rm = TRUE),
    Q3 = quantile(averageRating, 0.75, na.rm = TRUE)
  ) %>%
  mutate(IQR = Q3 - Q1)

# Print out the stats data frame
print(stats)

# Use a smaller multiplier (e.g., 1.0) to narrow the range
narrow_multiplier <- 0.6
lower_bound <- stats$Q1 - narrow_multiplier * stats$IQR
upper_bound <- stats$Q3 + narrow_multiplier * stats$IQR

# Print the lower andupper bound
cat("Narrowed Lower bound:", lower_bound, "\n")
cat("Narrowed Upper bound:", upper_bound, "\n")

# Filter out rows whose ⁠ averageRating ⁠ is outside the IQR-based bounds
merged_df_clean <- merged_df_clean %>%
  filter(averageRating >= lower_bound & averageRating <= upper_bound)

# Process genre column: keep only the first genre
merged_df_clean <- merged_df_clean %>%
  mutate(genres = sapply(strsplit(as.character(genres), ","), `[`, 1)) %>%
  mutate(genres = as.factor(genres))  # Convert to factor  # Convert to factor

# Choosing the genres (if the numVotes >= Total average of numVotes)
avg_votes_per_genre <- merged_df_clean %>%
  group_by(genres) %>%
  summarize(avg_numVotes = mean(numVotes, na.rm = TRUE))

overall_avg_votes <- mean(merged_df_clean$numVotes, na.rm = TRUE) 

# Identify genres with an average numVotes >= overall average
genres_to_keep <- avg_votes_per_genre %>%
  filter(avg_numVotes >= overall_avg_votes) %>%
  pull(genres)
print(genres_to_keep)

# We will keep these genres: "Action"  "Adventure" "Biography" "Crime"  "Horror" 
# Filter the original dataset to keep only those genres
merged_df_clean <- merged_df_clean %>%
  filter(as.character(genres) %in% genres_to_keep)

# Output: saved final cleaned dataset into a csv file
# Save the cleaned data to a CSV file
write_csv(merged_df_clean, file = here("data", "merged_df_clean.csv"))

# Print confirmation and final row count
cat("Cleaned dataset saved as 'merged_df_clean.csv'.\n")
cat("Total rows after cleaning:", nrow(merged_df_clean), "\n")