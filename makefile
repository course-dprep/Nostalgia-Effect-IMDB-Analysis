# This makefile will be used to automate the different steps in your project.
# Define directories
DATA_PREP_DIR = src/data-preparation
ANALYSIS_DIR = src/analysis

# Default target: run both data-preparation and analysis
all: analysis data-preparation

# Run data preparation
data-preparation:
	make -C $(DATA_PREP_DIR)

# Run analysis (depends on data-preparation)
analysis: data-preparation
	make -C $(ANALYSIS_DIR)

# Clean up generated files
clean:
	R -e "unlink('data', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE)"

.PHONY: all data-preparation analysis clean