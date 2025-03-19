REPORTING_DIR = .
RMD = RMarkdown\ for\ Project\ dprep.Rmd

# Default target: produce the final PDF report
all: $(REPORTING_DIR)/final_report.pdf

# Phony target for running the entire reporting step
.PHONY: reporting
reporting: all

# Rule to generate the final report PDF
# - Depends on your render_report.R script and the RMarkdown file
# - Calls Rscript on render_report.R (which contains your rmarkdown::render code)
$(REPORTING_DIR)/final_report.pdf: render_report.R $(REPORTING_DIR)/$(RMD)
	@echo "Rendering the final report..."
	Rscript render_report.R
	@echo "Report generated at $(REPORTING_DIR)/final_report.pdf"

# Clean up generated files
clean:
	rm -f $(REPORTING_DIR)/final_report.pdf
	@echo "Cleaned generated report files."
