library(XLConnect)

df <- readWorksheetFromFile("export.xls",header = FALSE, sheet = 1, startRow = 31, endRow = 44)
df

df1 <- t(df)
df1

df1 <- df1[,c(1,7:14,2,3,4,5,6)]
df1

df1 <- t(df1)
df1

df1 <- df1[,c(2:26)]
df1
#round(df1, digits = 0)
write.table(df1, file = "C:/GITHUB/Landuse Model Netlogo/built.csv",row.names=FALSE, na="",col.names=FALSE, sep=",",quote=FALSE)
