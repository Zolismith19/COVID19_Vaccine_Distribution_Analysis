# COVID-19 Vaccine Distribution Analysis

**Author:** Zoli Smith  
**Date:** April 2025

---

## Overview

This project analyzes Pfizer COVID-19 vaccine allocation data across U.S. jurisdictions using CDC data. It highlights disparities and trends in distribution using descriptive statistics, a summary table, and a stacked bar chart.

This repository includes:
- Summary statistics and jurisdiction-level allocation insights  
- A **summary table** of top 10 jurisdictions by allocation  
- A **stacked bar chart** comparing first and second dose allocations  
- A reproducible **reporting pipeline** using a Makefile and modular R scripts  

---

## Repository Structure

```
COVID_FINAL/
├── data/
│   └── DATASET.csv
├── report/
│   ├── FINAL550-ZOLI-G-S.Rmd
│   ├── FINAL550-ZOLI-G-S.html
│   ├── figures/
│   │   └── required_figure.png
│   └── tables/
│       └── required_table.html
├── scripts/
│   ├── create_required_figure.R
│   └── create_required_table.R
├── renv/
│   ├── activate.R
│   ├── settings.dcf
├── .Rprofile
├── renv.lock
├── FINAL550-ZOLI-G-S.Rmd
├── Dockerfile
├── Makefile
└── README.md
```

---

## How to Generate the Final Report

### Option 1: Using Make (Recommended)
```bash
make
```
This will:
- Generate `required_table.html` and `required_figure.png`
- Knit the `.Rmd` file into `report/FINAL550-ZOLI-G-S.html`

### Option 2: Using RStudio
1. Open `FINAL550-ZOLI-G-S.Rmd`
2. Click **Knit**
3. Ensure working directory is the project root (`COVID_FINAL/`)

---

## Required Table
- **Output:** `report/tables/required_table.html`
- **Generated by:** `scripts/create_required_table.R`
- **Description:** Top 10 jurisdictions by total vaccine allocations (1st + 2nd doses)

Regenerate manually with:
```r
source("scripts/create_required_table.R")
```

---

## Required Figure
- **Output:** `report/figures/required_figure.png`
- **Generated by:** `scripts/create_required_figure.R`
- **Description:** Stacked bar chart showing 1st vs. 2nd dose allocations in top 10 jurisdictions

Regenerate manually with:
```r
source("scripts/create_required_figure.R")
```

---

## Package Installation (with renv)

This project uses [`renv`](https://rstudio.github.io/renv/) for reproducibility. To restore the environment:

```bash
make install
```

---

## Dockerized Workflow (Fully Automated)

### Build the Image (Optional)
```bash
docker build -t zolig/covid-vaccine-report .
```

### Run the Container (Generates the Report)
```bash
make docker-run
```
This will:
- Pull `zolig/covid-vaccine-report`
- Mount your local `report/` directory
- Generate:
  - `report/figures/required_figure.png`
  - `report/tables/required_table.html`
  - `report/FINAL550-ZOLI-G-S.html`

---

## Windows Git Bash Users
If `docker run` fails with a path error, update the mount path like this:
```makefile
-v /$$(pwd)/report:/home/project/report
```

---

## DockerHub Image
Public Docker Image:
https://hub.docker.com/r/zolig/covid-vaccine-report

---

## Notes
- All file paths are relative and platform-independent
- Output files are **not versioned**; they’re created fresh each run
- Dockerfile avoids `COPY . .` and installs only required files
- Project is reproducible, portable, and clean

