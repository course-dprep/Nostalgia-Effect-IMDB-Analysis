# Define the data directory and the required merged data file.
DATA_DIR = ../../data
MERGED_DATA = $(DATA_DIR)/merged_df_clean.csv

# Default target: run the analysis script.
all: analysis

# Run the analysis script.
analysis: $(MERGED_DATA)
	@echo "Running analysis..."
	Rscript analysis.R

# Dependency: if the merged data is not found, notify the user.
$(MERGED_DATA):
	@echo "Error: Merged data not found at $(MERGED_DATA)."
	@echo "Please run the data-preparation Makefile first."
	@exit 1

.PHONY: all analysis clean

# Clean up any generated files (if applicable).
clean:
	@echo "Cleaning analysis outputs..."
	# Remove any generated files, e.g., plots (if saved)
	rm -f plot_yearly_ratings.pdf plot_genre_ratings.pdf plot_nostalgic_bias.pdf
