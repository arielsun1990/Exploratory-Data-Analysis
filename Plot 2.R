library(data.table)

# Read the original data
DT <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Convert the date
DT$Date <- as.Date(DT$Date, format  = "%d/%m/%Y")

# Subsetting by the date
data <- subset(DT, Date >= as.Date("2007-2-1") & Date <= "2007-2-2")
data$Global_active_power <- as.numeric(data$Global_active_power)

rm(DT)

# Convert the time & date into weekday
data$Datetime <- as.POSIXct(paste(data$Date, data$Time))

# Plotting
plot(data$Global_active_power~data$Datetime, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

# Save to png file
dev.copy(png, file = "plot2.png", height = 480, width = 480)

dev.off()
