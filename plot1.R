#install.packages("sqldf")
#library(sqldf)

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
myFileZip <- "household_power_consumption.zip"
myFile <- "household_power_consumption.txt"
oldDir <- getwd()
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

## plot a histogram with given parameters and save as png
## Note: reference plots have transparent background, but are shown on on white background; 
## to be as similar as possible, I have plotted them with bg="transparent" (instead of bg="white")
png(filename="plot1.png", width= 480, height=480, units="px", bg="transparent")
hist(mySet$Global_active_power, col=2, main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

setwd(oldDir)
