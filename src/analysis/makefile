# Define the data directory and the required merged data file.
DATA_DIR = ../../data
MERGED_DATA = $(DATA_DIR)/merged_df_clean.csv

# Default target: run both the analysis and the plotting scripts.
all: analysis plots

# Run the analysis script (analysis.R).
analysis: $(MERGED_DATA)
	@echo "Running analysis..."
	Rscript analysis.R

# Run the plots script (plots.R) to generate visualizations.
plots: $(MERGED_DATA)
	@echo "Generating plots..."
	Rscript plots.R

# Dependency check: if the merged data doesn't exist, show an error.
$(MERGED_DATA):
	@echo "Error: Merged data not found at $(MERGED_DATA)."
	@echo "Please run the data-preparation Makefile first."
	@exit 1

.PHONY: all analysis plots clean

# Clean up analysis outputs (e.g., generated PDF files).
clean:
	@echo "Cleaning analysis outputs..."
	rm -f plot_yearly_ratings.pdf plot_genre_ratings.pdf plot_nostalgic_bias.pdf
