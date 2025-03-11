# Load required libraries
library(dplyr) 
library(readr)
library(here)

# Print the total rows before cleaning
cat("Total rows before cleaning:", nrow(merged_df), "\n")

# Clean the dataset by removing rows with NA values
merged_df_clean <- merged_df %>%
  drop_na() # Remove rows with NA values

# Save the cleaned data to a CSV file
write_csv(merged_df_clean, file = here("data", "merged_df_clean.csv"))

cat("Cleaned dataset saved as 'merged_df_clean.csv'.\n")
cat("Total rows after cleaning:", nrow(merged_df_clean), "\n")

# View the cleaned dataset in RStudio
View(merged_df_clean)