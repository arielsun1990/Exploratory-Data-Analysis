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
with(data,
     {
       plot(data$Sub_metering_1~data$Datetime, xlab = "", ylab = "Energy sub metering", type = "l", col = "black")
       lines(data$Sub_metering_2~data$Datetime, type = "l", col = "red")
       lines(data$Sub_metering_3~data$Datetime, type = "l", col = "blue")
     }
)
       
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save to png file
dev.copy(png, file = "plot3.png", height = 480, width = 480)

dev.off()
