# Load required libraries
library(tidyr)
library(dplyr) 
library(readr)
library(here)

# Print the total rows before cleaning
cat("Total rows before cleaning:", nrow(data_merging), "\n")

# Clean the dataset by removing rows with NA values
merged_df_clean <- data_merging %>%
  drop_na() # Remove rows with NA values

# Remove the outliers in the data 
## Compute outlier bounds for `averageRating` using the IQR rule
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

cat("Narrowed Lower bound:", lower_bound, "\n")
cat("Narrowed Upper bound:", upper_bound, "\n")

# --- Process Genre Column: Keep Only the First Genre ---
# Many movies have multiple genres (e.g., "Action,Adventure").
# We extract only the first genre to simplify the analysis.
merged_df_clean <- merged_df_clean %>%
  mutate(genres = sapply(strsplit(as.character(genres), ","), `[`, 1)) %>%
  mutate(genres = as.factor(genres))  # Convert to factor

## Filter out rows whose `averageRating` is outside the IQR-based bounds
merged_df_clean <- merged_df_clean %>%
  filter(averageRating >= lower_bound & averageRating <= upper_bound)

# Save the cleaned data to a CSV file
write_csv(merged_df_clean, file = here("data", "merged_df_clean.csv"))

cat("Cleaned dataset saved as 'merged_df_clean.csv'.\n")
cat("Total rows after cleaning:", nrow(merged_df_clean), "\n")

# View the cleaned dataset in RStudio
View(merged_df_clean)

