DATA_DIR = ../../data

# Default target: run the analysis and save the plot for presentation
all: $(DATA_DIR)/plot_genre_ratings.pdf $(DATA_DIR)/plot_nostalgic_bias.pdf $(DATA_DIR)/plot_yearly_ratings.pdf

# Analysis target: produce imdb_ratings_vs_release_year.pdf
$(DATA_DIR)/imdb_ratings_vs_release_year.pdf : analysis.R $(DATA_DIR)/merged_df_clean.csv 
	@echo "Running the analysis and creating analysis plot"
	Rscript analysis.R

# Plots target: create the plot for ratings over time, ratings over genre, and nostalgic bias
$(DATA_DIR)/plot_yearly_ratings.pdf: plots.R $(DATA_DIR)/merged_df_clean.csv $(DATA_DIR)/imdb_ratings_vs_release_year.pdf
	Rscript plots.R

$(DATA_DIR)/plot_genre_ratings.pdf: plots.R $(DATA_DIR)/merged_df_clean.csv $(DATA_DIR)/imdb_ratings_vs_release_year.pdf
	Rscript plots.R

$(DATA_DIR)/plot_nostalgic_bias.pdf: plots.R $(DATA_DIR)/merged_df_clean.csv $(DATA_DIR)/imdb_ratings_vs_release_year.pdf
	Rscript plots.R

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
