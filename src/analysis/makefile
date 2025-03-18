DATA_DIR = ../../data

# Default target: all four PDF files
all: \
	$(DATA_DIR)/imdb_ratings_vs_release_year.pdf \
	$(DATA_DIR)/plot_yearly_ratings.pdf \
	$(DATA_DIR)/plot_genre_ratings.pdf \
	$(DATA_DIR)/plot_nostalgic_bias.pdf

# 1) Run the analysis script to produce imdb_ratings_vs_release_year.pdf
$(DATA_DIR)/imdb_ratings_vs_release_year.pdf: analysis.R $(DATA_DIR)/merged_df_clean.csv
	@echo "Running analysis..."
	Rscript analysis.R

# 2) Run the plots script to produce the other three PDFs (plot_yearly_ratings.pdf, plot_genre_ratings.pdf, plot_nostalgic_bias.pdf)
$(DATA_DIR)/plot_yearly_ratings.pdf $(DATA_DIR)/plot_genre_ratings.pdf $(DATA_DIR)/plot_nostalgic_bias.pdf: \
	plots.R \
	$(DATA_DIR)/merged_df_clean.csv \
	$(DATA_DIR)/imdb_ratings_vs_release_year.pdf
	@echo "Generating plots..."
	Rscript plots.R

# Optional: Clean up generated PDF files
.PHONY: clean
clean:
	rm -f \
	$(DATA_DIR)/imdb_ratings_vs_release_year.pdf \
	$(DATA_DIR)/plot_yearly_ratings.pdf \
	$(DATA_DIR)/plot_genre_ratings.pdf \
	$(DATA_DIR)/plot_nostalgic_bias.pdf