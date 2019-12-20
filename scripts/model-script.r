library('nnet')
data <- read.csv("./data/student_1213.csv", sep=";", na.strings = "")

data$STUDENT_SUBJECT_AREA_VALUE <- substr(data$STUDENT_SUBJECT_AREA_VALUE, 1, 2)
data$HOST_INSTITUTION_COUNTRY_CDE <- toupper(data$HOST_INSTITUTION_COUNTRY_CDE)
data$STUDENT_NATIONALITY_CDE <- toupper(data$STUDENT_NATIONALITY_CDE)
data$HOME_INSTITUTION_CTRY_CDE <- substr(data$HOME_INSTITUTION_CTRY_CDE, 1, 2)
data$HOST_INSTITUTION_COUNTRY_CDE <- substr(data$HOST_INSTITUTION_COUNTRY_CDE, 1, 2)
data$STUDENT_AGE_VALUE <- as.numeric(as.character(data$STUDENT_AGE_VALUE))
filtered <- data[data$HOME_INSTITUTION_CTRY_CDE != '??',]
filtered <- filtered[!is.na(filtered$HOME_INSTITUTION_CTRY_CDE),]
filtered <- filtered[filtered$HOST_INSTITUTION_COUNTRY_CDE != '??',]
filtered <- filtered[!is.na(filtered$HOST_INSTITUTION_COUNTRY_CDE),]
filtered <- filtered[filtered$STUDENT_GENDER_CDE != 'NA',] 
filtered <- filtered[filtered$STUDENT_AGE_VALUE != 'NA',]
filtered <- filtered[filtered$STUDENT_NATIONALITY_CDE != 'NA',]
filtered <- filtered[filtered$STUDENT_NATIONALITY_CDE != 'XX',]
filtered <- filtered[filtered$STUDENT_SUBJECT_AREA_VALUE != 'NA', ]
filtered <- filtered[filtered$HOST_INSTITUTION_COUNTRY_CDE == 'ES' | filtered$HOST_INSTITUTION_COUNTRY_CDE == 'UK',]
filtered$HOST_INSTITUTION_COUNTRY_CDE <- as.numeric(as.factor(filtered$HOST_INSTITUTION_COUNTRY_CDE))
filtered$HOST_INSTITUTION_COUNTRY_CDE <- filtered$HOST_INSTITUTION_COUNTRY_CDE-1

model <- glm(formula = HOST_INSTITUTION_COUNTRY_CDE ~ STUDENT_NATIONALITY_CDE + STUDENT_AGE_VALUE +
              STUDENT_SUBJECT_AREA_VALUE + STUDENT_GENDER_CDE, data = filtered, family = binomial())
s1 <- summary(model1)
