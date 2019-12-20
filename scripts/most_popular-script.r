## @knitr most_popular

# Libs
library(dplyr)
library(data.table)
library(ggplot2)
library(plotly)

#Load data
data <- read.csv("./data/student_1213.csv", sep=";")

data <- data %>% select(HOME_INSTITUTION_CDE, HOME_INSTITUTION_CTRY_CDE, HOST_INSTITUTION_CDE, HOST_INSTITUTION_COUNTRY_CDE, STUDENT_GENDER_CDE, STUDENT_SUBJECT_AREA_VALUE, STUDENT_STUDY_LEVEL_CDE)
data <- data %>% filter(STUDENT_SUBJECT_AREA_VALUE == 48 | STUDENT_SUBJECT_AREA_VALUE == 481 | STUDENT_SUBJECT_AREA_VALUE == 489)
data <- data %>% filter(HOST_INSTITUTION_CDE != "???") %>% group_by(HOST_INSTITUTION_CDE) %>% count() %>% arrange(-n)
top <- head(data, 10)
colnames(top)[1] <- "Host_institution_code"
colnames(top)[2] <- "Number_of_students"

popular <- ggplot(data=top, aes(x=Host_institution_code, y=Number_of_students)) +
  geom_bar(stat="identity") + 
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
ggplotly(popular)
