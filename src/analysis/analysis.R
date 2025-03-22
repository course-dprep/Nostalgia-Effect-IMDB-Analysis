# Load necessary libraries and initialize the script and setup
library(dplyr)    
library(ggplot2)  
library(readr)   
library(here)     
library(car)      
library(nortest)  

# Input: load cleaned and filtered dataset
merged_df_clean <- read_csv(here("data", "merged_df_clean.csv"))

# Transformation: run models, diagnostics, and sssumption checks
# Check number of unique genres
length(unique(merged_df_clean$genres))  # Should be manageable (<50)

# Regression 1: Effect of Release Year on IMDb Ratings
# This model tests whether movie ratings change over time.
model1 <- lm(averageRating ~ startYear, data = merged_df_clean)
summary(model1)  # View regression results

# Levene's Test for Homoschedasticity
leveneTest(resid(model1) ~ as.factor(merged_df_clean$startYear))

# Kolmogorov-Smirnov Test to check normality of residuals (Not Shapiro Wilk since the sample size is larger than 5000)
lillie.test(resid(model1))

# Check number of unique genres again
length(unique(merged_df_clean$genres))  # Ensure consistency

# Regression 2: interaction between release year and genre
# This model examines whether the relationship between release year and IMDb ratings differs based on the movie genre.
model2 <- lm(averageRating ~ startYear * genres, data = merged_df_clean)
summary(model2)  
print(model2)    

# VIF Test for Multicollinearity
vif(model2)  # Variance Inflation Factor test

# Levene's Test for Homoschedasticity
leveneTest(resid(model2) ~ genres, data = merged_df_clean)

# Kolmogorov-Smirnov test
by(resid(model2), merged_df_clean$genres, lillie.test)

# ANOVA: testing whether genres have a significant fffect on ratings
# This test checks if there are significant differences in IMDb ratings across genres.
anova_model <- aov(averageRating ~ genres, data = merged_df_clean)
summary(anova_model)  # View ANOVA results
print(anova_model)    # Print model details

# Levene's Test for Homoschedasticity
levene_test <- leveneTest(resid(anova_model) ~ genres, data = merged_df_clean)
print(levene_test)

# Regression 3: controlling for the number of votes (Bias Check)
# This model controls for the number of votes to check if nostalgia bias exists.
model3 <- lm(averageRating ~ startYear + numVotes, data = merged_df_clean)
summary(model3)  # View regression results

# VIF Test for Multicollinearity
vif(model3)  # Variance Inflation Factor test

# Levene's Test for Homoschedasticity
leveneTest(resid(model3) ~ as.factor(merged_df_clean$startYear))

# Kolmogorov-Smirnov test
# Used Kolmogorov-Smirnov test since the sample size is larger than 5000
lillie.test(resid(model3)) 

# Output: save visualization of ratings over time
# Visualization: IMDb ratings over time
# This scatter plot visualizes the relationship between release year and average ratings.
plot1 <- ggplot(merged_df_clean, aes(x = startYear, y = averageRating)) + 
  geom_point(alpha = 0.3) +  # Semi-transparent points
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  # Linear trendline
  labs(title = "IMDb Ratings vs. Release Year", 
       x = "Release Year", 
       y = "Average Rating")

# Create and save scatter plot with linear trendline
ggsave(plot = plot1, file = here("data", "imdb_ratings_vs_release_year.pdf"))

# Print message
cat("Analysis test done.\n")