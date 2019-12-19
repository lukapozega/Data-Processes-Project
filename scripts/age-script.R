## @knitr age_plot

library(reshape2)
library(plotly)

data <- read.csv("./data/student_1213.csv", sep=";", na.strings = "")

age <- data[, (5:6)]
age <- age[age$STUDENT_AGE_VALUE <= 30, ]
age$Male <- ifelse(age$STUDENT_GENDER_CDE == 'M', 1, 0)
age$Female <- ifelse(age$STUDENT_GENDER_CDE == 'F', 1, 0)
cols <- 3:4
age[,cols] <- apply(age[,cols], 2, function(x) as.numeric(as.character(gsub(",", "", x))))
age <- age[age$STUDENT_AGE_VALUE != 'Total', ] 
age$Male <- -1 * age$Male
age$STUDENT_AGE_VALUE <- factor(age$STUDENT_AGE_VALUE, levels = age$STUDENT_AGE_VALUE, labels = age$STUDENT_AGE_VALUE)
cols <- c(1,3,4)
age <- age[,cols]

# melted <- melt(age, 
#                 value.name='Population', 
#                 variable.name = 'Gender', 
#                 id.vars='STUDENT_AGE_VALUE' )

age <- as.data.frame(table(age))
age <- age[age$Freq > 0, ]
age$Gender <- ifelse(age$Male == -1, "Male", "Female")
age$STUDENT_AGE_VALUE <- as.numeric(as.character(age$STUDENT_AGE_VALUE))
age <- arrange(age, STUDENT_AGE_VALUE)
colnames(age)[1] <- 'Age'
colnames(age)[4] <- 'Count'

population <- ggplot(age, aes(x = Age, y = ifelse(Gender == "Male", -Count, Count),label = Count, fill = Gender)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal() +
  labs(y = "Count", x = "Age", title = "Age distribution")

ggplotly(population, tooltip = c("x", "label", "fill"))
