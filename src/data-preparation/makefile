DATA_DIR = data
RAW_DATA = $(DATA_DIR)/final_merged.csv
TITLE_BASICS_CLEANED = $(DATA_DIR)/title_basics_cleaned.csv
TITLE_RATINGS_CLEANED = $(DATA_DIR)/title_ratings_cleaned.csv
CLEAN_SCRIPT = clean.R

# Default target
all: $(RAW_DATA)

# Download raw data
.PHONY: download_data
download_data:
	@echo "Downloading raw data..."
	Rscript download-data.R

# Clean title basics
$(TITLE_BASICS_CLEANED): $(CLEAN_SCRIPT) | download_data
	@echo "Cleaning title basics..."
	Rscript $(CLEAN_SCRIPT)

# Clean title ratings
$(TITLE_RATINGS_CLEANED): $(CLEAN_SCRIPT) | download_data
	@echo "Cleaning title ratings..."
	Rscript $(CLEAN_SCRIPT)

# Merge cleaned data
$(RAW_DATA): data_merging.R $(TITLE_BASICS_CLEANED) $(TITLE_RATINGS_CLEANED)
	@echo "Merging data..."
	Rscript data_merging.R

# Clean generated files
.PHONY: clean
clean:
	rm -f $(TITLE_BASICS_CLEANED) $(TITLE_RATINGS_CLEANED) $(RAW_DATA)