#Load data
data <- read.csv("~/Downloads/SM_2012_13_20141103_01.csv", sep=";")

#Filter data
data <- data[!data$HOST_INSTITUTION_COUNTRY_CDE == "???",]

#Merge Belgium codes
#home
erasmushome <- data[, 4]
home <- as.matrix(table(erasmushome))
home <- rbind(home, matrix(home[3] + home[4]))
rownames(home)[36] = "BE"
home <- home[order(rownames(home)), ]
home <- home[-c(3, 4, 5)]
#host
erasmushost <- data[, 13]
host <- as.matrix(table(erasmushost))
host <- rbind(host, matrix(host[3] + host[4] + host[5]))
rownames(host)[37] = "BE"
host <- host[order(rownames(host)), ]
host <- host[-c(1, 4, 5, 6)]

#Join datasets
final <- as.data.frame(cbind(home, host))

#Country code manipulation
library(countrycode)
countries <- countrycode(rownames(final), "eurostat", "eurostat.name")
countries[13] <- "Greece"
countries[7] <- "Germany"
countries[33] <- "UK"
rownames(final) <- countries
final$region <- rownames(final)
final <- final[, c(3, 1, 2)]

#Create map
library(maps)
world <- map_data("world")
tojoin <- as.data.frame(matrix(
  nrow = length(table(world$region)),
  ncol = 3,
  NA,
  dimnames = list(names(table(world$region)), colnames(final))
))
tojoin$region <- rownames(tojoin)
library(dplyr)
all <- full_join(final, tojoin)
all <- all[order(all$region), ]
for (i in (1:251)) {
  if (all$region[i] == all$region[i + 1]) {
    all <- all[-c(i + 1), ]
  }
}
all$ratio <- all$host/all$home
mapbig <- inner_join(world, all, by = "region")
library(ggplot2)
worldmap <- ggplot() + theme(
  panel.background = element_rect(fill = "lightcyan1",
                                  color = NA),
  panel.grid = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  axis.ticks = element_blank(),
  axis.title.x = element_blank(),
  axis.title.y = element_blank()
)
europe <- worldmap + coord_fixed(xlim = c(-9, 42.5),
                                 ylim = c(36, 70.1),
                                 ratio = 1.5)
library(viridis)
europe2 <- europe + geom_polygon(data = mapbig,
    aes(fill = home,
       x = long,
       y = lat,
       group = group),
  color = "grey70") +
  labs(title = "Number of students enrolled in Erasmus by country, 2012-2013")  +
  scale_fill_viridis(option = "plasma",
    direction = -1,
    name = "",
    na.value = "grey80"
  )
europe2