# Dockerfile for Reproducible Report
FROM rocker/tidyverse:latest

# Set working directory inside the container
WORKDIR /project

RUN apt-get update && apt-get install -y \
    pandoc \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy renv environment setup files
COPY .Rprofile .
COPY renv.lock .
RUN mkdir renv
COPY renv/activate.R renv/
COPY renv/settings.dcf renv/

# Install renv and restore packages
RUN Rscript -e "install.packages('renv'); renv::restore(prompt = FALSE)"

# Create expected directories
RUN mkdir -p scripts data report

# Copy project files
COPY scripts/ scripts/
COPY data/ data/
COPY FINAL550-ZOLI-G-S.Rmd .

# Run the full pipeline when the container starts
CMD ["sh", "-c", \
  "Rscript scripts/create_required_table.R && \
   Rscript scripts/create_required_figure.R && \
   Rscript -e \"rmarkdown::render('FINAL550-ZOLI-G-S.Rmd', output_file = 'report/report.html')\""]


