## Read the data file from the site, unzip, and read into data frame
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "Household_power_consumption.zip")
unzip("Household_power_consumption.zip")
datafile <- read.table("Household_power_consumption.txt", header=TRUE, sep=";")

## Convert the Date and Time fields from string to date class
datafile$Time <- paste(datafile$Date, datafile$Time, sep = " ")
datafile$Date <- as.Date(datafile$Date, "%d/%m/%Y")
datafile$Time <- strptime(datafile$Time, format="%d/%m/%Y %H:%M:%S")

## Extract data for 2007-02-01 and 2007-02-02 into variable subdata
subdata <- subset(datafile, Date==as.Date("2007-02-01") | Date==as.Date("2007-02-02"))

## Create histogram of Global Active Power
par(mfrow=c(1,1))
hist(as.numeric(subdata$Global_active_power), col="red", 
     xlab="Global Active Power (kilowatts)", main="Global Active Power")

## Create a title
mtext("Plot 1", outer=TRUE, adj=0)

## Create png file
dev.copy(png, file="plot1.png")
dev.off()

