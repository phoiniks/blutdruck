#!/usr/bin/Rscript

library(DBI)
library(RSQLite)

lz <- format(Sys.Date(), "%d. %B %Y")

con = dbConnect(SQLite(), dbname = "blutdruck.db")
myQuery <- dbSendQuery(con, "SELECT * FROM blutdruck")

myData <- dbFetch(myQuery, n = -1)

systole <- unlist(myData$systole)
diastole <- unlist(myData$diastole)
puls <- unlist(myData$puls)
datum <- unlist(myData$datum)

plot(main=paste("Blutdruck", lz), x=systole, type="l", xlab="Systole", srt=60, xaxt="n", las=2, panel.first=grid(), col=c("red"))
axis(1, at=seq(systole), labels=datum, las=2, mgp=c(5, .7, 0), cex.axis=0.4)

plot(x=diastole, type="l", xlab="Diastole", srt=60, xaxt="n", las=2, panel.first=grid(), col=c("blue"))

plot(x=puls, type="l", xlab="Puls", srt=60, xaxt="n", las=2, panel.first=grid(), col=c("green"))

grid()
