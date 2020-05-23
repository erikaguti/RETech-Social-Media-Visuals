#Pretty fonts and basemaps
library(extrafont)
library(maps)

#read in data
data <- read.csv("hometowns.csv")

#open plot device
png(file="hometownbubble.png",width=2400,height=2400)

#create basemap
map('world',
    col="white", fill=TRUE, bg="#d8d8d8",
    border=0, 
    ylim=c(-60, 90)) 

#plot points
points(x=data$Long, y=data$Lat, col=adjustcolor("#f88d2b", alpha = .5),cex=data$Size, pch=19)

#need to run to access extrafont fonts
loadfonts(device = "win", quiet = TRUE)

#Create title and legend
title(main = list("Where We're From
                  ", par(cex.main = 7,
                         col.main = "white", family = "Segoe UI Light")))


legend(x=50, y = -35, "Hometown",col=adjustcolor("#f88d2b", alpha = .5), pch = 19, border = "white", cex = 3.5)

#finish
dev.off()