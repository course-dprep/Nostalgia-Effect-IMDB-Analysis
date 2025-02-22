# Load necessary library
library(dplyr)  # For data manipulation

if (!"title.ratings" %in% names(datasets)) {
  stop("Dataset 'title.ratings' not found in the 'datasets' list. Make sure it was loaded correctly.")
}




# Assign the dataset to a variable for easier manipulation
ratings_df <- datasets$title.ratings

# Convert necessary columns to numeric (since they are loaded as character by default)
ratings_df <- ratings_df %>%
  mutate(
    averageRating = as.numeric(averageRating),
    numVotes = as.numeric(numVotes)
  )

# Remove rows where averageRating or numVotes is NA
ratings_df_cleaned <- ratings_df %>%
  filter(!is.na(averageRating) & !is.na(numVotes))

# Verify the cleaning process
cat("Rows before cleaning:", nrow(ratings_df), "\n")
cat("Rows after cleaning:", nrow(ratings_df_cleaned), "\n")

# Store the cleaned dataset back in the list (optional)
datasets$title.ratings <- ratings_df_cleaned

# If you want to save the cleaned dataset as a new file
write_tsv(ratings_df_cleaned, file.path(tempdir(), "title.ratings_cleaned.tsv"))

cat("Cleaning complete. Cleaned dataset saved as 'title.ratings_cleaned.tsv'.\n")

