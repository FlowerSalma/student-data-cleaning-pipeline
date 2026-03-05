# Student Data Cleaning & Design Pipeline (R)

## Overview

This project demonstrates a reproducible data pipeline for cleaning,
validating, and integrating multi‑source student data using R.

The workflow simulates a common institutional analytics task: preparing
raw student datasets (demographics, grades, and GPA) and transforming
them into a structured **analysis‑ready master dataset**.

The pipeline highlights essential data science tasks such as **data
cleaning, validation, relational joins, and feature engineering**.

------------------------------------------------------------------------

## Project Structure

    student-data-cleaning-pipeline
    │
    ├── README.md
    ├── student-data-cleaning-pipeline.Rproj
    │
    ├── scripts
    │   ├── 00_make_raw_data.R
    │   ├── 01_clean_validate.R
    │   └── 02_build_master_table.R
    │
    └── data
        ├── raw
        └── processed

------------------------------------------------------------------------

## Workflow

### 1. Generate Raw Data

Script: `scripts/00_make_raw_data.R`

This script creates simulated raw datasets:

-   `students.csv`
-   `grades.csv`
-   `gpa.csv`

Saved in:

    data/raw/

The raw data intentionally contains: - duplicate records - inconsistent
country names - missing values - out-of-range grades

These issues simulate realistic data quality problems.

------------------------------------------------------------------------

### 2. Clean and Validate Data

Script: `scripts/01_clean_validate.R`

This step performs data cleaning and validation:

-   remove duplicate students
-   standardize country names
-   convert GPA to numeric
-   detect missing values
-   validate grade ranges
-   produce summary quality metrics

Cleaned datasets are written to:

    data/processed/

------------------------------------------------------------------------

### 3. Build Master Student Table

Script: `scripts/02_build_master_table.R`

This script integrates the cleaned datasets by:

-   joining tables using `student_id`
-   aggregating course grades
-   creating derived variables
-   engineering an **academic risk indicator**

Final output:

    data/processed/student_master.csv

------------------------------------------------------------------------

## Example Output

The final dataset includes variables such as:

-   `student_id`
-   `name`
-   `country`
-   `cohort`
-   `GPA`
-   `avg_grade`
-   `courses_taken`
-   `at_risk`

Where:

    at_risk = 1 if GPA < 3.0
    at_risk = 0 otherwise

------------------------------------------------------------------------

## How to Run the Pipeline

Run the scripts in order inside R:

``` r
source("scripts/00_make_raw_data.R")
source("scripts/01_clean_validate.R")
source("scripts/02_build_master_table.R")
```

After running these scripts, the cleaned dataset will appear in:

    data/processed/student_master.csv

------------------------------------------------------------------------

## Tools Used

-   R
-   dplyr
-   readr
-   tibble

------------------------------------------------------------------------

## Skills Demonstrated

This project demonstrates key data analytics and data engineering
skills:

-   Data cleaning
-   Data validation
-   Feature engineering
-   Relational joins
-   Reproducible data pipelines
-   Structured project organization

------------------------------------------------------------------------

## Author

Salma Hasannejad\
Mathematics & Data Science
