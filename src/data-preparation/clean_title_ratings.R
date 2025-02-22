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

# Calculate mean of numVotes (using the cleaned dataset)
mean_numVotes <- mean(ratings_df_cleaned$numVotes, na.rm=TRUE)
cat("Mean of numVotes:", mean_numVotes, "\n")

# Filter films with numVotes above or equal to the mean
ratings_above_mean <- ratings_df %>% 
  filter(numVotes >= mean_numVotes)

# Visualize the number of films with rating above the mean
cat("Number of films with numVotes over the mean:", nrow(ratings_above_mean), "\n")

# Filter with numVotes below the mean
ratings_below_mean <- ratings_df %>% 
  filter(numVotes < mean_numVotes)

# Visualize the number of films with rating below the mean 
cat("Number of films with numVotes below the mean:", nrow(ratings_below_mean), "\n") 
