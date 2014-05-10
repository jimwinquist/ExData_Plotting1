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

## Plot the data
png(file = "./data/plot1.png",width=480,height=480)
hist(as.numeric(new.range$Global_active_power), col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power", bg="transparent")
dev.off()