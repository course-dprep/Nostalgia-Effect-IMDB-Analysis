# Load required packages
if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  install.packages("rmarkdown")
}
if (!requireNamespace("tinytex", quietly = TRUE)) {
  install.packages("tinytex")
}

# Ensure TinyTeX is installed (only installs if missing)
if (!tinytex::is_tinytex()) {
  tinytex::install_tinytex()
}

# Install or update missing LaTeX packages
tinytex::tlmgr_install("scheme-basic")
tinytex::tlmgr_install("texlive-scripts")
tinytex::tlmgr_install("fmtutil")

# Detect the latest .Rmd file in the current directory
rmd_files <- list.files(pattern = "\\.Rmd$")
if (length(rmd_files) == 0) {
  stop("No RMarkdown (.Rmd) files found in the current directory.")
}

# Choose the first RMarkdown file (modify if needed)
input_file <- rmd_files[1]

# Choose LaTeX engine (change to "pdflatex" or "lualatex" if issues arise)
output_engine <- "xelatex"

# Render the RMarkdown file to PDF
rmarkdown::render(input = input_file, 
                  output_format = "pdf_document", 
                  output_options = list(latex_engine = output_engine))

message("✅ PDF successfully generated from: ", input_file)
