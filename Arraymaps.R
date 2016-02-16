library(rgdal)
Builtex <- readOGR(dsn = ".", "zones")  #dsn is a data source name

names(Builtex) #headings of the spatial dataframe
summary(Builtex)

proj4string(Builtex) <- CRS("init=epsg:32643)") # changing coordinate system of shapefile

library(rgeos)
library(ggplot2)

Builtex.f <- fortify(Builtex, region = "Zone_no_")

# fortify actually plots 

Builtex.f <- merge(Builtex.f, Builtex@data, by.x = "id", by.y = "Zone_no_")

# merge is required to merge the attribute table to the shapefiles.

head(Builtex.f[, 1:8])

Map <- ggplot(Builtex.f, aes(long, lat, group = group, fill = area)) + geom_polygon() + 
  coord_equal() + labs(x = "Easting (m)", y = "Northing (m)", fill = "Zone Area") + ggtitle( " Bhopal Zonal Map")
Map

#####################################################################################
#####################################################################################
#CREATION OF ARRAY MAP SHOWING ZONEWISE BUILT UP#####


library(ggplot2)

library(reshape2)

map.data <- read.csv("builtproj.csv")

map.data
# data contains area code and population of various years.

map.data.melt <- melt(map.data, id = c ("Zone_no_"))

plot.data <- merge(Builtex.f, map.data.melt, by.x = "id", by.y = "Zone_no_")

plot.data <- plot.data[order(plot.data$order), ]

q <- ggplot(data = plot.data, aes(x = long, y = lat, fill =value, group = group)) 
q  + geom_polygon() + geom_path(colour = "grey", lwd = 0.1) + coord_equal() + facet_wrap(~variable)
 
########################################################################################
######################################MAPPING WASTE GENERATION##################################################

library(ggplot2)

library(reshape2)

map.data <- read.csv("wastegen.csv")

map.data
# data contains area code and population of various years.

map.data.melt <- melt(map.data, id = c ("Zone_no_"))

plot.data <- merge(Builtex.f, map.data.melt, by.x = "id", by.y = "Zone_no_")

plot.data <- plot.data[order(plot.data$order), ]

q <- ggplot(data = plot.data, aes(x = long, y = lat, fill =value, group = group)) 
q  + geom_polygon() + geom_path(colour = "grey", lwd = 0.1) + coord_equal() + facet_wrap(~variable)

##################################################################################
##########################MAPPING CONGESTION FACTOR############################3##

library(ggplot2)

library(reshape2)

map.data <- read.csv("originalcong.csv")

map.data
# data contains area code and population of various years.

map.data.melt <- melt(map.data, id = c ("Zone_no_"))

plot.data <- merge(Builtex.f, map.data.melt, by.x = "id", by.y = "Zone_no_")

plot.data <- plot.data[order(plot.data$order), ]

q <- ggplot(data = plot.data, aes(x = long, y = lat, fill =value, group = group)) 
q  + geom_polygon + geom_path(colour = "grey", lwd = 0.05) + coord_equal() + facet_wrap(~variable)

