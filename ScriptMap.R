# Reading Shapefile into R  

library(rgdal)
map1 <-readOGR (dsn = ".", "zones")
## summary(map1)

library(ggplot2)
## p <-ggplot(map1@data, aes(a1,a2))
## p + geom_point()

# Fortifying with a2, Map showing according to a1
map1.f <-fortify(map1, region = "area")
map1.f <-merge(map1.f, map1@data, by.x = "id", by.y = "area")
head (map1.f)
finalmap <-ggplot(map1.f, aes(long, lat, group=group, fill= Zone_no_))+geom_polygon()+coord_equal()
ggtitle ("Trialmap")
finalmap

#Reading Xls data from Stella

library(XLConnect)
wk = loadWorkbook("export.xls")


#Reading data from shapefile attribute table as dbf 

library(foreign)
dbfdata <-read.dbf("zones.dbf")

#Extracting data from excel file from Stella according to Zones

df <- readWorksheetFromFile("export.xls",header = FALSE, sheet = 1, startRow = 31, endRow = 44)
df  # This file has no header

names(df) <- c("Zone_no_","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030","2031","2032","2033","2034","2035")

df1 <- t(df)
df1

df1 <- df1[,c(1,7:14,2,3,4,5,6)] # arranging columns 
df1

df1 <- t(df1)
df1

df1 <- df1[,c(1:26)]
df1

df1[1,1] = "1"
df1[2,1] = "2"
df1[3,1] = "3"
df1[4,1] = "4"
df1[5,1] = "5"
df1[6,1] = "6"
df1[7,1] = "7"
df1[8,1] = "8"
df1[9,1] = "9"
df1[10,1] = "10"
df1[11,1] = "11"
df1[12,1] = "12"
df1[13,1] = "13"
df1[14,1] = "14"

df1
### end extracting data

# for joining one field has to be the same as in shapefile

#library(data.table)
#(setattr(df1, "row.names", c("a", "b", "c")))


# Joining table with the shapefile
library(raster)
# read data    
p <- shapefile("zones.shp")
d <- df1

# merge on common variable, here called 'key'
m <- merge(p, d, by='Zone_no_')

# perhaps save as shapefile again
shapefile(m, "zonesmerged.shp")

library(foreign)
dbfdata1 <-read.dbf("zonesmerged.dbf")
dbfdata1

#plotting a new map



library(rgdal)
map1 <-readOGR (dsn = ".", "zonesmerged")
## summary(map1)

library(ggplot2)
## p <-ggplot(map1@data, aes(a1,a2))
## p + geom_point()

# Fortifying with a2, Map showing according to a1
map1.f <-fortify(map1, region = "2011")
map1.f <-merge(map1.f, map1@data, by.x = "id", by.y = "2011")
head (map1.f)
finalmap <-ggplot(map1.f, aes(long, lat, group=group, fill= Zone_no_))+geom_polygon()+coord_equal()
ggtitle ("Trialmap")
finalmap


