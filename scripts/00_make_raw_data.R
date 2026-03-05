library(readr)
library(dplyr)
library(tibble)

dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)

students <- tibble(
  student_id = c("S001","S002","S002","S003","S004"),
  name       = c("Alice","Bob","Bob","Carla","David"),
  country    = c("USA","U.S.","United States","Canada","usa"),
  cohort     = c("2025","2025","2025","2026","2026")
)

grades <- tibble(
  student_id = c("S001","S001","S002","S003","S004"),
  course     = c("Math","CS","Math","Math","CS"),
  grade      = c(85, 90, 70, 105, 60)
)

gpa <- tibble(
  student_id = c("S001","S002","S003","S004"),
  GPA        = c("3.6","2.8", NA, "4.3")
)

write_csv(students, "data/raw/students.csv")
write_csv(grades,   "data/raw/grades.csv")
write_csv(gpa,      "data/raw/gpa.csv")

cat("Created: data/raw/students.csv, grades.csv, gpa.csv\n")