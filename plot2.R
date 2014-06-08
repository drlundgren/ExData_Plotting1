#install.packages("sqldf")
#library(sqldf)

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
myFileZip <- "household_power_consumption.zip"
myFile <- "household_power_consumption.txt"
oldDir <- getwd()
OldLocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

setwd("~/coursera-exploratory-data-analysis/")
if (!file.exists(myFile)) {
    # download.file(fileUrl, destfile = myFileZip, method = "curl") ## on MAC
    download.file(fileUrl, destfile = myFileZip)
    dateDownloaded <- date()
}

## read the zip file (we have enough memory so we read everything, for simplicity)
myDataTest <- read.table(unz(myFileZip, myFile), header=TRUE, sep=";", stringsAsFactors = FALSE, dec =".", na.strings = "?")

## subset the read data based on two given dates
mySet <- subset(myDataTest, Date=="1/2/2007" | Date=="2/2/2007" )

## date manipulation
dateTime <- paste(mySet$Date, mySet$Time)
dateTime2 <- as.POSIXlt(strptime(dateTime, "%d/%m/%Y %H:%M:%S"))

## plot to png file with appropriate parameters
## Note: reference plots have transparent background, but are shown on on white background; 
## to be as similar as possible, I have plotted them with bg="transparent" (instead of bg="white")
png(filename="plot2.png", width= 480, height=480, units="px", bg="transparent")
plot(dateTime2, mySet$Global_active_power, type="l",main="", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

## restore some settings
setwd(oldDir)
Sys.setlocale("LC_TIME", OldLocale)