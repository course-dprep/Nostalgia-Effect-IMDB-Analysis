# Load necessary libraries
library(dplyr)    # For data manipulation
library(ggplot2)  # For visualization
library(readr)    # For reading CSV files
library(here)     # For project directory management
library(car)      # For VIF calculation
library(nortest)  # Load the nortest library for Kolmogorov-Smirnov test

# Load Cleaned Dataset
merged_df_clean <- read_csv(here("data", "merged_df_clean.csv"))

# Check Number of Unique Genres
length(unique(merged_df_clean$genres))  # Should be manageable (<50)

# Regression 1: Effect of Release Year on IMDb Ratings
# This model tests whether movie ratings change over time.
model1 <- lm(averageRating ~ startYear, data = merged_df_clean)
summary(model1)  # View regression results

# Levene's Test for Homoschedasticity
leveneTest(resid(model1) ~ as.factor(merged_df_clean$startYear))

# Kolmogorov-Smirnov Test to check normality of residuals (Not Shapiro Wilk since the sample size is larger than 5000)
lillie.test(resid(model1))

# Check Number of Unique Genres Again
length(unique(merged_df_clean$genres))  # Ensure consistency

# Regression 2: Interaction Between Release Year and Genre
# This model examines whether the relationship between release year and IMDb ratings 
# differs based on the movie genre.
model2 <- lm(averageRating ~ startYear * genres, data = merged_df_clean)
summary(model2)  # View regression results
print(model2)    # Print model details

# VIF Test for Multicollinearity
vif(model2)  # Variance Inflation Factor test

# Levene's Test for Homoschedasticity
leveneTest(resid(model2) ~ genres, data = merged_df_clean)

# Kolmogorov-Smirnov test
by(resid(model2), merged_df_clean$genres, lillie.test)

# ANOVA: Testing Whether Genres Have a Significant Effect on Ratings
# This test checks if there are significant differences in IMDb ratings across genres.
anova_model <- aov(averageRating ~ genres, data = merged_df_clean)
summary(anova_model)  # View ANOVA results
print(anova_model)    # Print model details

# Levene's Test for Homoschedasticity
levene_test <- leveneTest(resid(anova_model) ~ genres, data = merged_df_clean)
print(levene_test)

# Regression 3: Controlling for the Number of Votes (Bias Check)
# This model controls for the number of votes to check if nostalgia bias exists.
model3 <- lm(averageRating ~ startYear + numVotes, data = merged_df_clean)
summary(model3)  # View regression results

# VIF Test for Multicollinearity
vif(model3)  # Variance Inflation Factor test

# Levene's Test for Homoschedasticity
leveneTest(resid(model3) ~ as.factor(merged_df_clean$startYear))

# Kolmogorov-Smirnov test
lillie.test(resid(model3)) # Used Kolmogorov-Smirnov test since the sample size is larger than 5000

# Visualization: IMDb Ratings Over Time
# This scatter plot visualizes the relationship between release year and average ratings.
plot1 <- ggplot(merged_df_clean, aes(x = startYear, y = averageRating)) + 
  geom_point(alpha = 0.3) +  # Semi-transparent points
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  # Linear trendline
  labs(title = "IMDb Ratings vs. Release Year", 
       x = "Release Year", 
       y = "Average Rating")

ggsave(plot = plot1, file = here("data", "imdb_ratings_vs_release_year.pdf"))
cat("Analysis test done.\n")