# Load necessary libraries and initialize the script and setup
library(rmarkdown)
library(tinytex)
library(here)

# Input: setup and ensure Pandoc is available
rmarkdown::find_pandoc()

# Output: render the RMarkdown file and output as PDF into the "reporting" folder
rmarkdown::render('Rmarkdown for Project dprep.Rmd', output_file = here("reporting", "final_report.pdf"))