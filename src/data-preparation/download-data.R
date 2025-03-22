# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Install and load necessary libraries
if (!require("data.table")) install.packages("data.table", dependencies = TRUE)
if (!require("here")) install.packages("here", dependencies = TRUE)
if (!require("nortest")) install.packages("nortest", dependencies = TRUE)
if (!require("R.utils")) install.packages("R.utils", dependencies = TRUE)
if (!require("tidyverse")) install.packages("tidyverse", dependencies = TRUE)
if (!require("lubridate")) install.packages("lubridate", dependencies = TRUE)
if (!require("readr")) install.packages("readr", dependencies = TRUE)
if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)
if (!require("rmarkdown")) install.packages("rmarkdown", dependencies = TRUE)
if (!require("tinytex")) install.packages("tinytex", dependencies = TRUE)
if (!require("knitr")) install.packages("knitr", dependencies = TRUE)

# Ensure "data" folder exists
dir.create(here("data"), showWarnings = FALSE)

# Input: setup and download IMDb datasets
# Download IMDb datasets
download.file("https://datasets.imdbws.com/title.basics.tsv.gz", 
              destfile = here("data", "title_basics.tsv.gz"))
download.file("https://datasets.imdbws.com/title.ratings.tsv.gz", 
              destfile = here("data", "title_ratings.tsv.gz"))

# OUTPUT: confirmation message
cat("All datasets successfully downloaded to the data folder.\n")