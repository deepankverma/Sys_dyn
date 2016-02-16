library(XLConnect)

df <- readWorksheetFromFile("export.xls",header = FALSE, sheet = 1, startRow = 580, endRow = 593)
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
write.table(df1, file = "C:/GITHUB/Sys_dyn/wastegen1.csv",row.names=FALSE, na="",col.names=FALSE, sep=",",quote=FALSE)
