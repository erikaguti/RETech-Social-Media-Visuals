#base on code found here: https://www.gis-blog.com/flight-connection-map-with-r/

#Pretty maps and fonts
library(maps)
library(extrafont)

#geospatial calculations
library(geosphere)

#read in data
consultants <- read.csv("ConsultantTravel.csv")
engineers <- read.csv("EngineerTravel.csv")

#initiate png object
png(file="Work Travel.png",width=2400,height=2400)

#create basemap
map('world',
    col='white', fill=TRUE, bg="#d8d8d8",
    border=0, 
    ylim=c(-60, 90)) 

#adding US borders to basemap bc why not
map("state", col = "#d8d8d8", fill = FALSE, add = TRUE)


#generates great circle lines from the start points to the travel points

#start points
Falls_Church <-c(-77.1711,38.8823)
Minneapolis <- c(-93.265,44.9778)

#lines to travel points
for (i in (1:dim(consultants)[1])) { 
  inter <- gcIntermediate(Falls_Church, c(consultants$Long[i], consultants$Lat[i]), n=50)
  lines(inter, lwd=1, col="#1c4c56", lty = 1)    
}

for (i in (1:dim(engineers)[1])) { 
  inter <- gcIntermediate(Minneapolis, c(engineers$Long[i], engineers$Lat[i]), n=50)
  lines(inter, lwd=1, col="#ee9c07", lty = 1)    
}

#special case because default gcIntermediate output was not aesthetically pleasing.
#creates straight line so that entire line can be seen in the map

Shanghai <- c(121.4747,31.25516 )

b <- bearingRhumb(Minneapolis, Shanghai)
dr <- distRhumb(Minneapolis, Shanghai)
pr <- destPointRhumb(Minneapolis, b, d=round(dr/100)*1:140)
lines(pr, lwd=1, col="#ee9c07", lty = 1)


#need to run to access extrafont fonts
loadfonts(device = "win", quiet = TRUE)

#create title and legend
title(main = list("Where We've Been
                  ", par(cex.main = 6,col.main = "white", family = "Segoe UI Light")))

legend(x=-15, y = -37.5, c("RE Tech Consulting HQ: Falls Church, VA", "RE Tech Engineering HQ: Minneapolis, MN"),col = c("#1c4c56","#ee9c07"), pch = 20,pt.cex = 5, border = "white", cex = 3.5)

#add start points to map
points(-77.1711,38.8823, col="#1c4c56",cex=3.5, pch=20)
points(-93.265,44.9778, col ="#ee9c07", cex=3.5, pch=20)

#finish
dev.off()