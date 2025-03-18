DATA_DIR = ../../data

# Default target
all: $(DATA_DIR)/merged_df_clean.csv

# Download raw data (assumes download-data.R writes some raw files to data/)
.PHONY: download_data
download_data:
	@echo "Downloading raw data..."
	Rscript download-data.R

# Clean title ratings (produces data/title_ratings_cleaned.csv)
$(DATA_DIR)/title_ratings_cleaned.csv: clean.R | download_data
	@echo "Cleaning title ratings..."
	Rscript clean.R

# Clean title basics (produces data/title_basics_cleaned.csv)
$(DATA_DIR)/title_basics_cleaned.csv: clean.R | download_data
	@echo "Cleaning title basics..."
	Rscript clean.R
	
# Merge cleaned data into a final file (data/final_merged.csv)
$(DATA_DIR)/final_merged.csv: data_merging.R $(DATA_DIR)/title_basics_cleaned.csv $(DATA_DIR)/title_ratings_cleaned.csv
	@echo "Merging data..."
	Rscript data_merging.R

# Clean merged data into a final file (data/merged_df_clean.csv)
$(DATA_DIR)/merged_df_clean.csv: clean_data_merging.R $(DATA_DIR)/final_merged.csv
	@echo "Cleaning merged data..."
	Rscript clean_data_merging.R

# Clean generated files
.PHONY: clean
clean:
	rm -f $(DATA_DIR)/title_basics_cleaned.csv $(DATA_DIR)/title_ratings_cleaned.csv $(DATA_DIR)/final_merged.csv $(DATA_DIR)/merged_df_clean.csv
