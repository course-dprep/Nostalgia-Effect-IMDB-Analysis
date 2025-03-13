# Install and load necessary libraries
if (!require("data.table")) install.packages("data.table", dependencies = TRUE)
if (!require("here")) install.packages("here", dependencies = TRUE)

library(data.table)
library(here)

# Ensure "data" folder exists
dir.create(here("data"), showWarnings = FALSE)

# Download IMDb datasets
download.file("https://datasets.imdbws.com/title.basics.tsv.gz", 
              destfile = here("data", "title_basics.tsv.gz"))
download.file("https://datasets.imdbws.com/title.ratings.tsv.gz", 
              destfile = here("data", "title_ratings.tsv.gz"))

cat("All datasets successfully downloaded to the data folder.\n")

# Load datasets into R environment
title_basics <- fread(here("data", "title_basics.tsv.gz"), sep = "\t", na.strings = "\\N", quote = "")
title_ratings <- fread(here("data", "title_ratings.tsv.gz"), sep = "\t", na.strings = "\\N", quote = "")

# Verify that data is loaded
print(dim(title_basics))  # Should show number of rows and columns
print(dim(title_ratings)) # Should show number of rows and columns
