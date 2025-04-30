.PHONY: install all clean docker-run

install:
	Rscript -e "renv::restore()"

all: report/FINAL550-ZOLI-G-S.html

report/figures/required_figure.png: scripts/create_required_figure.R data/DATASET.csv
	Rscript scripts/create_required_figure.R

report/tables/required_table.html: scripts/create_required_table.R data/DATASET.csv
	Rscript scripts/create_required_table.R

report/FINAL550-ZOLI-G-S.html: report/FINAL550-ZOLI-G-S.Rmd report/tables/required_table.html report/figures/required_figure.png
	Rscript -e "rmarkdown::render('report/FINAL550-ZOLI-G-S.Rmd', output_file = 'FINAL550-ZOLI-G-S.html', output_dir = 'report')"

clean:
	rm -f report/*.html report/figures/*.png report/tables/*.html

.PHONY: docker-run

docker-run:
	docker run --rm -v "$$(pwd)/report:/home/project/report" zolig/covid-vaccine-report






