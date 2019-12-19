## @knitr area_plot

library(dplyr)

data <- read.csv("./data/student_1213.csv", sep=";", na.strings = "")

data$STUDENT_SUBJECT_AREA_VALUE <- substr(data$STUDENT_SUBJECT_AREA_VALUE, 1, 2)
data$STUDENT_SUBJECT_AREA_VALUE <- as.numeric(data$STUDENT_SUBJECT_AREA_VALUE)
areas <- data[, 8]
areas <- as.data.frame(table(areas))
areas <- arrange(areas, -Freq)
areas <- head(areas, 10)
areas[1,3] <- "Bussines, management"
areas[2,3] <- "Humanities"
areas[3,3] <- "Social and political science, economics"
areas[4,3] <- "Engineering"
areas[5,3] <- "Medicine"
areas[6,3] <- "Law"
areas[7,3] <- "Architecture"
areas[8,3] <- "Music, art, fashion"
areas[9,3] <- "Education"
areas[10,3] <- "Physics"
colnames(areas)[3] <- "Study_area"
colnames(areas)[2] <- "Students"
bar <- ggplot(data=areas, aes(x=Study_area, y=Students)) +
  geom_bar(stat="identity", fill="steelblue")+
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
ggplotly(bar)
