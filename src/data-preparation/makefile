# 1) "all" is the default target that triggers the entire workflow.
all: data/final_merged.csv

# 2) Download raw data (assumes download-data.R writes some raw files to data/).
.PHONY: download_data
download_data:
	@echo "Downloading raw data..."
	Rscript download-data.R

# 3) Clean title basics (produces data/title_basics_cleaned.csv).
# The target now depends on the download_data step.
data/title_basics_cleaned.csv: clean_title_basics.R | download_data
	@echo "Cleaning title basics..."
	Rscript clean_title_basics.R

# 4) Clean title ratings (produces data/title_ratings_cleaned.csv).
# The target now depends on the download_data step.
data/title_ratings_cleaned.csv: clean_title_ratings.R | download_data
	@echo "Cleaning title ratings..."
	Rscript clean_title_ratings.R

# 5) Merge the cleaned data into a final file (data/final_merged.csv).
data/final_merged.csv: data_merging.R data/title_basics_cleaned.csv data/title_ratings_cleaned.csv
	@echo "Merging data..."
	Rscript data_merging.R

# Optional: a 'clean' target to remove generated files.
clean:
	rm -f ../../data/title_basics_cleaned.csv ../../data/title_ratings_cleaned.csv ../../data/final_merged.csv