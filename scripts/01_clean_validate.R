library(dplyr)
library(readr)
library(stringr)

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

students <- read_csv("data/raw/students.csv", show_col_types = FALSE)
gpa      <- read_csv("data/raw/gpa.csv",      show_col_types = FALSE)
grades   <- read_csv("data/raw/grades.csv",   show_col_types = FALSE)

# ---- Basic validation: required columns ----
stopifnot(all(c("student_id","name","country","cohort") %in% names(students)))
stopifnot(all(c("student_id","GPA") %in% names(gpa)))
stopifnot(all(c("student_id","course","grade") %in% names(grades)))

# ---- Cleaning: students ----
students_clean <- students %>%
  mutate(
    student_id = str_trim(student_id),
    country = str_to_lower(str_trim(country)),
    country = case_when(
      country %in% c("usa","u.s.","united states","united states of america") ~ "usa",
      country %in% c("canada") ~ "canada",
      country %in% c("mexico") ~ "mexico",
      TRUE ~ country
    )
  ) %>%
  distinct(student_id, .keep_all = TRUE)  # remove duplicates by student_id

# ---- Cleaning: gpa ----
gpa_clean <- gpa %>%
  mutate(
    student_id = str_trim(student_id),
    GPA = as.numeric(GPA)
  ) %>%
  mutate(
    GPA = ifelse(GPA < 0 | GPA > 4, NA, GPA)   # enforce GPA range
  ) %>%
  distinct(student_id, .keep_all = TRUE)

# ---- Cleaning: grades ----
grades_clean <- grades %>%
  mutate(
    student_id = str_trim(student_id),
    grade = as.numeric(grade)
  ) %>%
  mutate(
    grade = ifelse(grade < 0 | grade > 100, NA, grade)  # enforce grade range
  )

# ---- Quality report ----
quality_report <- tibble(
  n_students_raw = nrow(students),
  n_students_clean = nrow(students_clean),
  duplicates_removed = n_students_raw - n_students_clean,
  missing_gpa = sum(is.na(gpa_clean$GPA)),
  missing_grade = sum(is.na(grades_clean$grade))
)

print(quality_report)

# Save cleaned tables
write_csv(students_clean, "data/processed/students_clean.csv")
write_csv(gpa_clean,      "data/processed/gpa_clean.csv")
write_csv(grades_clean,   "data/processed/grades_clean.csv")
write_csv(quality_report, "data/processed/quality_report.csv")

cat("Saved cleaned tables to data/processed/\n")

