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

## Convert Sub_metering fields from character to numeric class
subdata$Sub_metering_1 <- as.numeric(subdata$Sub_metering_1)
subdata$Sub_metering_2 <- as.numeric(subdata$Sub_metering_2)
subdata$Sub_metering_3 <- as.numeric(subdata$Sub_metering_3)

## Create line group for Sub_metering against time
par(mfrow=c(1,1))
with(subdata, plot(Time, Sub_metering_1, type = "l", 
                   ylab="Energy sub metering", xlab=""))
with(subdata, points(Time, Sub_metering_2, type="l", col="red"))
with(subdata, points(Time, Sub_metering_3, type="l", col="blue"))

legend("topright", lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Creat a title for the graph
mtext("Plot 3", outer=TRUE, adj=0)

## Create png file
dev.copy(png, file="plot3.png")
dev.off()