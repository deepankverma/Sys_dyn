library(XLConnect)

df <- readWorksheetFromFile("export.xls",header = FALSE, sheet = 1, startRow = 465, endRow = 478)
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
write.table(df1, file = "C:/GITHUB/Sys_dyn/uncollected.csv",row.names=FALSE, na="",col.names=FALSE, sep=",",quote=FALSE)
