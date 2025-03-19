# Load required libraries
library(rmarkdown)
library(tinytex)
library(here)

# render_report.R
rmarkdown::find_pandoc()
rmarkdown::render('Rmarkdown for Project dprep.Rmd', output_file = here("reporting", "final_report.pdf"))


