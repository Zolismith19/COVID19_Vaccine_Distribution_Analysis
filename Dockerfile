FROM rocker/tidyverse:latest

WORKDIR /home/project

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    pandoc

RUN mkdir -p scripts data report

COPY scripts/create_required_figure.R scripts/
COPY scripts/create_required_table.R scripts/
COPY data/DATASET.csv data/

RUN Rscript -e "install.packages(c('here', 'writexl', 'readxl', 'scales', 'pacman', 'gt'))"

CMD ["sh", "-c", "Rscript scripts/create_required_figure.R && Rscript scripts/create_required_table.R"]



