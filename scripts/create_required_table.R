

library(tidyverse)
library(gt)

data <- read_csv("data/DATASET.csv")


table_data <- data %>%
  filter(!is.na(`1st Dose Allocations`), !is.na(`2nd Dose Allocations`)) %>%
  group_by(Jurisdiction) %>%
  summarise(
    First_Dose = sum(`1st Dose Allocations`, na.rm = TRUE),
    Second_Dose = sum(`2nd Dose Allocations`, na.rm = TRUE)
  ) %>%
  arrange(desc(First_Dose + Second_Dose)) %>%
  slice_head(n = 10) %>%
  gt() %>%
  tab_header(
    title = "Top 10 Jurisdictions by Vaccine Allocations",
    subtitle = "Summed allocations of first and second doses"
  )


dir.create("report/tables", showWarnings = FALSE, recursive = TRUE)

gtsave(table_data, "report/tables/required_table.html")

