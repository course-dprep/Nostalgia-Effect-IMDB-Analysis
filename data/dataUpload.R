# Install and load necessary libraries
if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
if (!require("readr")) install.packages("readr", dependencies = TRUE)
if (!require("R.utils")) install.packages("R.utils", dependencies = TRUE)

library(readr)  # For reading .tsv files
library(R.utils)  # For extracting .gz files
library(dplyr)  # For data manipulation

# Base URL for downloading the datasets
base_url <- "https://datasets.imdbws.com/"

# List of dataset filenames to download
files <- c("title.basics.tsv.gz", "title.ratings.tsv.gz")

# Temporary directory to store downloaded files
download_dir <- tempdir()

# List to store the loaded datasets
datasets <- list()

# Function to download a file with retry mechanism
download_with_retry <- function(url, destfile, max_attempts = 3) {
  attempt <- 1
  success <- FALSE
  
  while (attempt <= max_attempts && !success) {
    cat(sprintf("Attempt %d to download %s...\n", attempt, basename(destfile)))
    
    tryCatch({
      download.file(url, destfile, mode = "wb", quiet = TRUE)
      success <- TRUE  # If download succeeds, mark as success
    }, error = function(e) {
      cat(sprintf("Error: %s\n", e$message))
    })
    
    if (!success) {
      cat("Retrying...\n")
      attempt <- attempt + 1
    }
  }
  
  if (!success) {
    stop(sprintf("Failed to download %s after %d attempts.\n", basename(destfile), max_attempts))
  }
}

# Loop to check, download, extract, and load each dataset
for (file in files) {
  file_path <- file.path(download_dir, file)  # Define the local path for the file
  extracted_file <- sub(".gz$", "", file_path)  # Define the extracted file name
  
  # Check if the extracted file already exists to avoid redundant downloads
  if (!file.exists(extracted_file)) {
    file_url <- paste0(base_url, file)
    
    # Check if compressed file already exists before downloading
    if (!file.exists(file_path)) {
      download_with_retry(file_url, file_path)
    }
    
    # Remove existing extracted file to avoid conflicts
    if (file.exists(extracted_file)) {
      file.remove(extracted_file)
    }
    
    # Extract the .gz file
    gunzip(file_path, destname = extracted_file, remove = FALSE)
  } else {
    cat(sprintf("File %s already extracted. Skipping extraction.\n", basename(extracted_file)))
  }
  
  # Load the dataset into a data frame
  dataset_name <- sub(".tsv.gz$", "", file)  # Extract dataset name without extensions
  datasets[[dataset_name]] <- read_tsv(extracted_file, col_types = cols(.default = "c"), na = "\\N")
}

cat("All datasets successfully downloaded and loaded.\n")

