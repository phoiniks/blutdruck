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

plot(main=paste("Systole", lz), x=systole, type="l", xlab="", srt=60, xaxt="n", las=2, panel.first=grid(), col=c("red"))
axis(1, at=seq(systole), labels=datum, las=2, mgp=c(5, .7, 0), cex.axis=0.4)
grid()

plot(main=paste("Diastole", lz), x=diastole, type="l", xlab="", srt=60, xaxt="n", las=2, panel.first=grid(), col=c("blue"))
axis(1, at=seq(diastole), labels=datum, las=2, mgp=c(5, .7, 0), cex.axis=0.4)
grid()

plot(main=paste("Puls", lz), x=puls, type="l", xlab="", srt=60, xaxt="n", las=2, panel.first=grid(), col=c("green"))
axis(1, at=seq(puls), labels=datum, las=2, mgp=c(5, .7, 0), cex.axis=0.4)
grid()
