## @knitr model_trees

library('nnet')
library("dummies")
data <- read.csv("./data/student_1213.csv", sep=";", na.strings = "")

data$STUDENT_SUBJECT_AREA_VALUE <- substr(data$STUDENT_SUBJECT_AREA_VALUE, 1, 2)
data$HOST_INSTITUTION_COUNTRY_CDE <- toupper(data$HOST_INSTITUTION_COUNTRY_CDE)
data$STUDENT_NATIONALITY_CDE <- toupper(data$STUDENT_NATIONALITY_CDE)
data$HOME_INSTITUTION_CTRY_CDE <- substr(data$HOME_INSTITUTION_CTRY_CDE, 1, 2)
data$STUDENT_AGE_VALUE <- as.numeric(as.character(data$STUDENT_AGE_VALUE))
filtered <- data[data$HOME_INSTITUTION_CTRY_CDE != '???',]
filtered <- filtered[!is.na(filtered$HOME_INSTITUTION_CTRY_CDE),]
filtered <- filtered[filtered$HOST_INSTITUTION_COUNTRY_CDE != '???',]
filtered <- filtered[!is.na(filtered$HOST_INSTITUTION_COUNTRY_CDE),]
filtered <- filtered[filtered$STUDENT_GENDER_CDE != 'NA',] 
filtered <- filtered[filtered$STUDENT_AGE_VALUE != 'NA',]
filtered <- filtered[filtered$STUDENT_NATIONALITY_CDE != 'NA',]
filtered <- filtered[filtered$STUDENT_NATIONALITY_CDE != 'XX',]
filtered <- filtered[filtered$STUDENT_SUBJECT_AREA_VALUE != 'NA', ]
filtered$HOST_INSTITUTION_COUNTRY_CDE <- factor(filtered$HOST_INSTITUTION_COUNTRY_CDE)
filtered$HOST_INSTITUTION_COUNTRY_CDE <- as.numeric(filtered$HOST_INSTITUTION_COUNTRY_CDE)

#Information : 
str(filtered)
dn = sort(sample(nrow(filtered), nrow(filtered)*.5))
filtered = filtered[dn,]


# Training/test set 
dt = sort(sample(nrow(filtered), nrow(filtered)*.8))
filtered_train<-filtered[dt,]
filtered_test<-filtered[-dt,]
#model

Sys.setenv(JAVA_HOME="")
library('rJava')
library('RWeka')

#Dummification of the attributes : 
myvars <- c("HOST_INSTITUTION_COUNTRY_CDE", "STUDENT_NATIONALITY_CDE",
            "STUDENT_AGE_VALUE","STUDENT_SUBJECT_AREA_VALUE","STUDENT_GENDER_CDE")
df_new= filtered[myvars]

df_new <- cbind(df_new, dummy(df_new$STUDENT_NATIONALITY_CDE, sep = "_"))
df_new <- cbind(df_new, dummy(df_new$STUDENT_SUBJECT_AREA_VALUE, sep = "_"))

df_reg <- subset(df_new, select = -c(STUDENT_NATIONALITY_CDE, STUDENT_SUBJECT_AREA_VALUE))


#Train/test set 
dt = sort(sample(nrow(df_reg), nrow(df_reg)*.8))
train<-df_reg[dt,]
test<-df_reg[-dt,]

#Java option
options(java.parameters = "-Xmx4g") 

# Train
m.m5p <- M5P(HOST_INSTITUTION_COUNTRY_CDE ~ ., data = train)
summary(m.m5p)
m.m5p

# Predict
p.m5p <- predict(m.m5p, test)


# Try diffrent measures
cor(p.m5p, test$HOST_INSTITUTION_COUNTRY_CDE)
MAE <- function(actual, predicted) {mean(abs(actual - predicted))}
MAE(test$HOST_INSTITUTION_COUNTRY_CDE, p.m5p)
mean(train$HOST_INSTITUTION_COUNTRY_CDE)
actual <- train$HOST_INSTITUTION_COUNTRY_CDE
MAE(18.46, test$HOST_INSTITUTION_COUNTRY_CDE)

