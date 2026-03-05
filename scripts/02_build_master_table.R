library(dplyr)
library(readr)

students <- read_csv("data/processed/students_clean.csv", show_col_types = FALSE)
gpa      <- read_csv("data/processed/gpa_clean.csv",      show_col_types = FALSE)
grades   <- read_csv("data/processed/grades_clean.csv",   show_col_types = FALSE)

grade_summary <- grades %>%
  group_by(student_id) %>%
  summarise(
    avg_grade = mean(grade, na.rm = TRUE),
    courses_taken = n(),
    .groups = "drop"
  )

student_master <- students %>%
  left_join(gpa, by = "student_id") %>%
  left_join(grade_summary, by = "student_id") %>%
  mutate(
    at_risk = ifelse(is.na(GPA), NA, ifelse(GPA < 3.0, 1, 0))
  )

print(student_master)

write_csv(student_master, "data/processed/student_master.csv")
cat("Saved: data/processed/student_master.csv\n")
