library(ggplot2)

#Load data
data <- read.csv("~/Downloads/SM_2012_13_20141103_01.csv", sep=";")

gender <- data[, 6]
gender <- as.matrix(table(gender))
colnames(gender)[1] <- "Number"
gender <- as.data.frame(gender)
setDT(gender, keep.rownames = TRUE)[]
gender$type <- rownames(gender)
gender <- gender %>%
  mutate(prop = round(Number*100/sum(Number), 1),
         ypos = cumsum(prop) - 0.7*prop)

pie <- ggplot(gender, aes(x = "", y = prop, fill = gender)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  geom_text(aes(y = ypos, label = prop), color = "white")+
  coord_polar("y", start = 0)+
  ggpubr::fill_palette("jco")+
  ggtitle("Difference between genders") +
  theme_void()

