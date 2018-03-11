library(dplyr)

# Download, Unzip, and Look at a sample of these data
if(!file.exists("household_power_consumption.txt")) {
  system("wget https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
  system("unzip exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

readLines("household_power_consumption.txt", n = 10)

# Prepare for plotting
d <- read.delim("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", stringsAsFactors = FALSE)
d$Date <- as.Date(d$Date, format = "%d/%m/%Y")
d <- filter(d, Date <= "2007-02-02" & Date >= "2007-02-01")

# Plot 
png(filename = "plot1.png")
hist(
  d$Global_active_power, 
  xlim = c(0,6),
  xlab = "Global Active Power (kilowats)", 
  main = "Global Active Power",
  col = "red"
)
dev.off()

