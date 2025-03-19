# Default target: run everything (using the phony target "report")
all: data-preparation analysis reporting

# 1) Run the data-preparation step (calls the makefile in src/data-preparation)
data-preparation:
	make -C src/data-preparation

# 2) Run the analysis step (calls the makefile in src/analysis)
#    This step depends on data-prep having been run.
analysis: data-preparation
	make -C src/analysis

# 3) Render the final report (using RMarkdown)
#    This depends on analysis, so that the cleaned data and analysis outputs are available.
reporting: analysis
	@echo "Generating final report..."
	R -e "rmarkdown::render(input = 'reporting/RMarkdown for Project dprep.Rmd', output_file='reporting/final_report.pdf')"
	@echo "Report generated."

# Clean up all generated files from subdirectories and the final report
clean:
	R -e "unlink('../../data', recursive = TRUE)"
	R -e "unlink('reporting/final_report.pdf', recursive = FALSE)"
