DATA_DIR = ../../data

.PHONY: all analysis plots clean

# Default target: run both analysis and plots
all: analysis plots

# Rule to build merged_df_clean.csv by delegating to the data-preparation Makefile
$(DATA_DIR)/merged_df_clean.csv:
	$(MAKE) -C ../data-preparation

# Analysis target: produce imdb_ratings_vs_release_year.pdf
analysis: $(DATA_DIR)/imdb_ratings_vs_release_year.pdf

$(DATA_DIR)/imdb_ratings_vs_release_year.pdf: analysis.R $(DATA_DIR)/merged_df_clean.csv
	@echo "Running analysis..."
	Rscript analysis.R

# Plots target: produce plot_yearly_ratings.pdf, plot_genre_ratings.pdf, and plot_nostalgic_bias.pdf
plots: $(DATA_DIR)/plot_yearly_ratings.pdf $(DATA_DIR)/plot_genre_ratings.pdf $(DATA_DIR)/plot_nostalgic_bias.pdf

$(DATA_DIR)/plot_yearly_ratings.pdf $(DATA_DIR)/plot_genre_ratings.pdf $(DATA_DIR)/plot_nostalgic_bias.pdf: \
	plots.R \
	$(DATA_DIR)/merged_df_clean.csv \
	$(DATA_DIR)/imdb_ratings_vs_release_year.pdf
	@echo "Generating plots..."
	Rscript plots.R

# Clean up generated PDF files
clean:
	rm -f $(DATA_DIR)/imdb_ratings_vs_release_year.pdf \
	      $(DATA_DIR)/plot_yearly_ratings.pdf \
	      $(DATA_DIR)/plot_genre_ratings.pdf \
	      $(DATA_DIR)/plot_nostalgic_bias.pdf
