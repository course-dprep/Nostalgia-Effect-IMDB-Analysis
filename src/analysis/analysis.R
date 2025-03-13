# Load necessary libraries
library(dplyr)    # For data manipulation
library(ggplot2)  # For visualization
library(readr)    # For reading CSV files
library(here)     # For project directory management
library(car)

# --- Load Cleaned Dataset ---
merged_df_clean <- read_csv(here("data", "merged_df_clean.csv"))

# --- Process Genre Column: Keep Only the First Genre ---
# Many movies have multiple genres (e.g., "Action,Adventure").
# We extract only the first genre to simplify the analysis.
merged_df_clean <- merged_df_clean %>%
  mutate(genres = sapply(strsplit(as.character(genres), ","), `[`, 1)) %>%
  mutate(genres = as.factor(genres))  # Convert to factor

# --- Check Number of Unique Genres ---
length(unique(merged_df_clean$genres))  # Should be manageable (<50)

# --- Regression 1: Effect of Release Year on IMDb Ratings ---
# This model tests whether movie ratings change over time.
model1 <- lm(averageRating ~ startYear, data = merged_df_clean)
summary(model1)  # View regression results

# --- Check Number of Unique Genres Again ---
length(unique(merged_df_clean$genres))  # Ensure consistency

# --- Regression 2: Interaction Between Release Year and Genre ---
# This model examines whether the relationship between release year and IMDb ratings 
# differs based on the movie genre.
model2 <- lm(averageRating ~ startYear * genres, data = merged_df_clean)
summary(model2)  # View regression results
print(model2)    # Print model details

# --- ANOVA: Testing Whether Genres Have a Significant Effect on Ratings ---
# This test checks if there are significant differences in IMDb ratings across genres.
anova_model <- aov(averageRating ~ genres, data = merged_df_clean)
summary(anova_model)  # View ANOVA results
print(anova_model)    # Print model details

# --- Regression 3: Controlling for the Number of Votes (Bias Check) ---
# This model controls for the number of votes to check if nostalgia bias exists.
model3 <- lm(averageRating ~ startYear + numVotes, data = merged_df_clean)
summary(model3)  # View regression results

# --- Visualization: IMDb Ratings Over Time ---
# This scatter plot visualizes the relationship between release year and average ratings.
ggplot(merged_df_clean, aes(x = startYear, y = averageRating)) + 
  geom_point(alpha = 0.3) +  # Semi-transparent points
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  # Linear trendline
  labs(title = "IMDb Ratings vs. Release Year", 
       x = "Release Year", 
       y = "Average Rating")

# --- Check for Linearity ---
ggplot(data.frame(fitted = fitted(model1), residuals = resid(model1)), aes(x = fitted, y = residuals)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "loess", color = "blue") +
  labs(title = "Residuals vs. Fitted Values", x = "Fitted Values", y = "Residuals") +
  theme_minimal()

# --- Levene's Test for Homoschedasticity ---
leveneTest(resid(model1) ~ as.factor(merged_df_clean$startYear))

# --- Shapiro-Wilk Test to check normality of residuals ---
ggplot(data.frame(residuals = resid(model1)), aes(sample = residuals)) +
  stat_qq() +
  stat_qq_line() +
  labs(title = "QQ Plot of Residuals") +
  theme_minimal()
shapiro.test(resid(model1))

# ---VIF test to check multicollinearity
vif(model1)
