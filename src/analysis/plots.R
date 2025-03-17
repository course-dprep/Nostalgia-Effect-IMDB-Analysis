#  Part 1: Setup

# Load necessary libraries
library(tidyverse)  
library(ggplot2)
library(dplyr)
library(here)

#  Part 2: Load Data
data_merging <- read_csv(here("data","merged_df_clean.csv"))

# Convert 'startYear' to numeric
data_merging <- data_merging %>%
  mutate(startYear = as.numeric(startYear))

#  Part 3: Relationship Between Release Year and Rating

# 3.1 Average rating over release year
yearly_ratings <- data_merging %>%
  group_by(startYear) %>%
  summarize(
    avg_rating = mean(averageRating, na.rm = TRUE),
    count = n()  # how many titles released that year
  ) %>%
  ungroup()

# 3.2 Line plot of average rating over the years
plot1 <- ggplot(data = yearly_ratings, aes(x = startYear, y = avg_rating)) +
  geom_line(color = "blue") + 
  labs(
    title = "Average IMDb Rating Over Release Year",
    x = "Release Year",
    y = "Average Rating"
  ) +
  theme_minimal()
print(plot1)

#  Part 4: Genre-Specific Visualization

# Some rows might have multiple genres, so separate them into multiple rows
merged_df_genres <- data_merging %>%
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

#  Part 5: Highlighting Nostalgic Bias

# One way to highlight nostalgia is to compare older vs. newer titles. 
# For example, focusing on a single genre or comparing the earliest years to the latest ones:
# Below is a scatter that covers all years.

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

#  Save Plots

ggsave("plot_yearly_ratings.pdf", plot = plot1)
ggsave("plot_genre_ratings.pdf", plot = plot2)
ggsave("plot_nostalgic_bias.pdf", plot = plot3)

