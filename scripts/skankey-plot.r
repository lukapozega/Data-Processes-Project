## @knitr skankey

library(dplyr)
library(tidyr)
library(plotly)

data <- read.csv("./data/student_1213.csv", sep=";", na.strings = "")

data <- data %>% select(HOME_INSTITUTION_CDE, HOME_INSTITUTION_CTRY_CDE, HOST_INSTITUTION_CDE, HOST_INSTITUTION_COUNTRY_CDE, STUDENT_GENDER_CDE, STUDENT_SUBJECT_AREA_VALUE, STUDENT_STUDY_LEVEL_CDE)
names <- data.frame(c(as.vector(data$HOME_INSTITUTION_CTRY_CDE), as.vector(data$HOST_INSTITUTION_COUNTRY_CDE)))
names(names)[1] <- "label"
names <- names %>% distinct(label) %>% mutate(id = row_number())
# data <- data %>% filter(STUDENT_SUBJECT_AREA_VALUE == 48 | STUDENT_SUBJECT_AREA_VALUE == 481 | STUDENT_SUBJECT_AREA_VALUE == 489)
data <- data %>% filter(HOME_INSTITUTION_CTRY_CDE != "???" & HOST_INSTITUTION_COUNTRY_CDE != "???") %>% group_by(HOST_INSTITUTION_COUNTRY_CDE, HOME_INSTITUTION_CTRY_CDE) %>% count() %>% arrange(-n)
data <- left_join(data,names, by = c("HOME_INSTITUTION_CTRY_CDE" = "label"))
names(data)[4] <- "id_source"
data <- left_join(data,names, by = c("HOST_INSTITUTION_COUNTRY_CDE" = "label"))
names(data)[5] <- "id_target"


p <- plot_ly(
  type = "sankey",
  domain = list(
    x =  c(0,1),
    y =  c(0,1)
  ),
  orientation = "h",
  valueformat = "0",
  valuesuffix = "Students",
  
  node = list(
    label = names$label,
    color = "rgba(255,123,254,0.9)",
    pad = 15,
    thickness = 15,
    line = list(
      color = "black",
      width = 0.5
    )
  ),
  
  link = list(
    source = data$id_source,
    target = data$id_target,
    value =  data$n,
    label =  data$HOST_INSTITUTION_COUNTRY_CDE
  )
) %>%
  layout(
    title = "Flow of Students within the participating countries",
    font = list(
      size = 10
    ),
    xaxis = list(showgrid = F, zeroline = F),
    yaxis = list(showgrid = F, zeroline = F)
  )
p
