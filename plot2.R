library(dplyr)
library(tidyr)
# Download if necessary
if(!file.exists("household_power_consumption.txt")) {
  system("wget https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
  system("unzip exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

# Look at data
readLines("household_power_consumption.txt", n = 10)

# Prepare for plotting
d <- read.delim("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", stringsAsFactors = FALSE)
d$Date <- as.Date(d$Date, format = "%d/%m/%Y")

d <- filter(d, Date <= "2007-02-02" & Date >= "2007-02-01")
d <- unite(d, col = "DateTime", Date, Time, sep = " ")
d$DateTime <- as.POSIXct(d$DateTime)

png(filename = "plot2.png")
plot(
  d$DateTime,  d$Global_active_power,
  type = "l",
  ylab = "Global Active Power (kilowatts)",
  xlab= ""
)
dev.off()