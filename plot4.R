library(dplyr)
library(tidyr)

# Download if necessary
if(!file.exists("household_power_consumption.txt")) {
  system("wget https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
  system("unzip exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

# Look at sample of data
readLines("household_power_consumption.txt", n = 10)

# Prepare for plotting
d <- read.delim("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", stringsAsFactors = FALSE)
d$Date <- as.Date(d$Date, format = "%d/%m/%Y")

d <- filter(d, Date <= "2007-02-02" & Date >= "2007-02-01")
d <- unite(d, col = "DateTime", Date, Time, sep = " ")
d$DateTime <- as.POSIXct(d$DateTime)

png(filename = "plot3.png")
par(mfrow=c(2,2))
plot(
  d$DateTime,  d$Global_active_power,
  type = "l",
  ylab = "Global Active Power (kilowatts)",
  xlab= ""
)
plot(
  d$DateTime, d$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)
plot(
  d$DateTime,  d$Sub_metering_1,
  type = "l",
  ylab = "Global Active Power (kilowatts)",
  xlab= "",
  col = "black"
)
lines(
  d$DateTime,  d$Sub_metering_2,
  type = "l",
  col = "red"
)
lines(d$DateTime, d$Sub_metering_3,
      type = "l",
      col = "blue"
)  
legend(x = "topright",, legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"), lty = c(1,1,1), col = c("black","red","blue"))
plot(
  d$DateTime, d$Global_reactive_power,
  type = "l",
  xlab = "datetime",
  ylab = "Global_reactive_power"
)
dev.off()
