.PHONY: all data-prep analysis report clean

# Default target: run everything (using the phony target "report")
all: data-preparation analysis reporting

# 1) Run the data-preparation step (calls the makefile in src/data-preparation)
data-preparation:
	@echo "Running data-preparation..."
	$(MAKE) -C src/data-preparation

# 2) Run the analysis step (calls the makefile in src/analysis)
#    This step depends on data-prep having been run.
analysis: data-preparation
	@echo "Running analysis..."
	$(MAKE) -C src/analysis

# 3) Render the final report (using RMarkdown)
#    This depends on analysis, so that the cleaned data and analysis outputs are available.
reporting: analysis
	@echo "Generating final report..."
	Rscript -e "rmarkdown::render('reporting/RMarkdown for Project dprep.Rmd', output_dir='reporting')"
	@echo "Report generated: reporting/RMarkdown-for-Project-dprep.pdf"

# Clean up all generated files from subdirectories and the final report
clean:
	$(MAKE) -C src/data-preparation clean
	$(MAKE) -C src/analysis clean
	rm -f reporting/RMarkdown-for-Project-dprep.pdf
