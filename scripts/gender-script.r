## @knitr gender_pie_plot

library(ggplot2)
library(dplyr)

#Load data
data <- read.csv("./data/student_1213.csv", sep=";")

gender <- data[, 6]
gender <- as.matrix(table(gender))
colnames(gender)[1] <- "Number"
gender <- as.data.frame(gender)
gender$type <- rownames(gender)
colnames(gender)[2] = "gender"
gender <- gender %>%
  mutate(prop = 100-round(Number*100/sum(Number), 1),
         rat = round(Number*100/sum(Number), 1),
         ypos = cumsum(prop) - 0.6*prop)

pie <- ggplot(gender, aes(x = "", y = rat, fill = gender)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  geom_text(aes(y = ypos, label = prop), color = "white")+
  coord_polar("y", start = 0)+
  ggpubr::fill_palette("jco")+
  ggtitle("Difference between genders") +
  theme_void()
pie
