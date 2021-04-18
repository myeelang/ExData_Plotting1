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

## Create line graph of Global Active Power against Time
par(mfrow=c(1,1))

with(subdata, plot(Time, Global_active_power, type="l", 
                   ylab="Global Active Power (kilowatts)", xlab=""))

## Put a title of the graph
mtext("Plot 2", outer=TRUE, adj=0)

## Create png file
dev.copy(png, file="plot2.png")
dev.off()
