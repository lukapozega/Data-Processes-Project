## @knitr strength_of_relationship

# Libs
library(dplyr)

#Load data
data <- read.csv("./data/student_1213.csv", sep=";")
data <- data %>% select(HOME_INSTITUTION_CDE, HOME_INSTITUTION_CTRY_CDE, HOST_INSTITUTION_CDE, HOST_INSTITUTION_COUNTRY_CDE, STUDENT_GENDER_CDE, STUDENT_SUBJECT_AREA_VALUE, STUDENT_STUDY_LEVEL_CDE)
data <- data %>% filter(STUDENT_SUBJECT_AREA_VALUE == 48 | STUDENT_SUBJECT_AREA_VALUE == 481 | STUDENT_SUBJECT_AREA_VALUE == 489)


