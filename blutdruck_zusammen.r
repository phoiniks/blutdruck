#!/usr/bin/Rscript

library(DBI)
library(RSQLite)

lz <- format(Sys.Date(), "%d. %B %Y")

con = dbConnect(SQLite(), dbname = "blutdruck.db")
myQuery <- dbSendQuery(con, "SELECT * FROM blutdruck")

myData <- dbFetch(myQuery, n = -1)

datum <- unlist(myData$datum)
name <- unlist(myData$name)
systole <- unlist(myData$systole)
diastole <- unlist(myData$diastole)
puls <- unlist(myData$puls)

plot(main=paste("Blutdruck", lz), c(1,length(datum)), c(0,180), type="n", xlab=name[1], ylab="Systole (rot)/Diastole (blau)/Puls (grün)", lty=3)

lines(myData$systole, col="red")
lines(myData$diastole, col="blue")
lines(myData$puls, col="green")
