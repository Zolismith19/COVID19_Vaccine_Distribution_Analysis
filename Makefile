# Makefile for Final Project 8: Dockerized R Report
.PHONY: install all clean docker-run run

# Restore renv packages locally
install:
	Rscript -e "renv::restore()"

# Default target: generate full HTML report locally
all: report/FINAL550-ZOLI-G-S.html

# Generate figure from script and dataset
report/figures/required_figure.png: scripts/create_required_figure.R data/DATASET.csv
	Rscript scripts/create_required_figure.R

# Generate table from script and dataset
report/tables/required_table.html: scripts/create_required_table.R data/DATASET.csv
	Rscript scripts/create_required_table.R

# Render final report using RMarkdown
report/FINAL550-ZOLI-G-S.html: FINAL550-ZOLI-G-S.Rmd report/tables/required_table.html report/figures/required_figure.png
	Rscript -e "rmarkdown::render('FINAL550-ZOLI-G-S.Rmd', output_file = 'FINAL550-ZOLI-G-S.html', output_dir = 'report')"

# Clean up generated outputs
clean:
	rm -f report/*.html report/figures/*.png report/tables/*.html

# Run the Docker image and mount local report directory
run:
	docker run -v "$$(pwd)/report":/project/report zolig/covid-vaccine-report

# Optional alias with different mount path for Windows Git Bash users
docker-run:
	docker run --rm -v "/$$(pwd)/report:/home/project/report" zolig/covid-vaccine-report




Version: 0.1
SnapshotType: implicit

