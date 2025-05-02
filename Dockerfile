FROM rocker/tidyverse:latest

WORKDIR /project

RUN apt-get update && apt-get install -y \
    pandoc \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p scripts data report renv

COPY .Rprofile renv.lock ./
COPY renv/activate.R renv/settings.dcf ./renv/

RUN Rscript -e "install.packages('renv', repos = 'https://cloud.r-project.org'); renv::restore(prompt = FALSE)"

COPY scripts/ ./scripts/
COPY data/ ./data/
COPY FINAL550-ZOLI-G-S.Rmd ./

CMD ["sh", "-c", \
  "Rscript scripts/create_required_table.R && \
   Rscript scripts/create_required_figure.R && \
   Rscript -e \"rmarkdown::render('FINAL550-ZOLI-G-S.Rmd', output_file = 'report/report.html')\""]





