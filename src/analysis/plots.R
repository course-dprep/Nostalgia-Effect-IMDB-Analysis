# Load necessary libraries and initialize the script and setup
library(tidyverse)  
library(ggplot2)
library(dplyr)
library(here)

# Input: load cleaned dataset
merged_df_clean <- read_csv(here("data","merged_df_clean.csv"))

# Convert 'startYear' to numeric
merged_df_clean <- merged_df_clean %>%
  mutate(startYear = as.numeric(startYear))

# Calculate average rating and count of titles by year
yearly_ratings <- merged_df_clean %>%
  group_by(startYear) %>%
  summarize(
    avg_rating = mean(averageRating, na.rm = TRUE),
    count = n()  # how many titles released that year
  ) %>%
  ungroup()

# Plot: Average rating by release year (line plot)
plot1 <- ggplot(data = yearly_ratings, aes(x = startYear, y = avg_rating)) +
  geom_line(color = "blue") + 
  labs(
    title = "Average IMDb Rating Over Release Year",
    x = "Release Year",
    y = "Average Rating"
  ) +
  theme_minimal()
print(plot1)

# Some rows might have multiple genres, so separate them into multiple rows
merged_df_genres <- merged_df_clean %>%
  separate_rows(genres, sep = ",")

# Computing average rating by year & genre
genre_ratings_by_year <- merged_df_genres %>%
  group_by(startYear, genres) %>%
  summarize(
    avg_rating = mean(averageRating, na.rm = TRUE),
    n = n()
  ) %>%
  ungroup()

# Plot: average rating by year, colored by genre
plot2 <- ggplot(genre_ratings_by_year, aes(x = startYear, y = avg_rating, color = genres)) +
  geom_line() +
  labs(
    title = "Average IMDb Rating by Genre Over Release Year",
    x = "Release Year",
    y = "Average Rating",
    color = "Genre"
  ) +
  theme_minimal()
print(plot2)

# One way to highlight nostalgia is to compare older vs. newer titles. 
# For example, focusing on a single genre or comparing the earliest years to the latest ones:
# Use LOESS to emphasize non-linear trends in average rating
plot3 <-ggplot(yearly_ratings, aes(x = startYear, y = avg_rating)) +
  geom_point(color = "red") +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Potential Nostalgic Bias: Trend of Ratings Over Time",
    x = "Release Year",
    y = "Average Rating"
  ) +
  theme_minimal()
print(plot3)

# Explanation:
# - geom_point() shows individual yearly average ratings
# - geom_smooth() draws a trend line, indicating whether older movies

#  Output: Save plots as PDFs into the data/reporting folder
ggsave(plot = plot1, file = here("data", "plot_yearly_ratings.pdf"))
ggsave(plot = plot2, file = here("data", "plot_genre_ratings.pdf"))
ggsave(plot = plot3, file = here("data", "plot_nostalgic_bias.pdf"))

# Print final message
cat("Plots correctly saved.\n")