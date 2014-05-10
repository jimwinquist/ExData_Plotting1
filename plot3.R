## Download and unzip the data file for the course project
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "./data/power_consumption.zip"
download.file(fileUrl, destfile, method="curl")
unzip(destfile, exdir="./data")
## Read power.data from text file and create new datetime field by combining $Date and $Time variables
power.data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character")
power.data$Datetime <- as.POSIXct(strptime(paste(power.data$Date, power.data$Time), "%d/%m/%Y%H:%M:%S"), tz = "EST")

## Subset data based on specified frame range
new.range <- with(power.data, subset(power.data, 
                                     power.data$Datetime >= as.POSIXct('2007-02-01 00:00:00', tz="EST") 
                                     & power.data$Datetime < as.POSIXct('2007-02-03 00:00:00', tz="EST")))

## Plot the Data
png(file = "./data/plot3.png",width=480,height=480)
plot(new.range$Datetime, as.numeric(new.range$Sub_metering_1), col="black",
      type = "l", xlab = "", ylab = "Energy sub metering")
lines(new.range$Datetime, as.numeric(new.range$Sub_metering_2), col="red")
lines(new.range$Datetime, as.numeric(new.range$Sub_metering_3), col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1,1,1))
dev.off()