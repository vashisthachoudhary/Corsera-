memory_estimate <- 2075259 * 9 * 8 / (1024^2) # in MB
print(memory_estimate) # ~142 MB
# Load required libraries
install.packages("data.table")

library(data.table)

# Read data and filter relevant dates
file_path <- "household_power_consumption.txt"
data <- fread(file_path, na.strings = "?", sep = ";")

# Convert Date and Time to appropriate formats
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
subset_data <- data[data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))]

# Combine Date and Time into a single datetime column
subset_data$Datetime <- as.POSIXct(paste(subset_data$Date, subset_data$Time))
png("plot1.png", width = 480, height = 480)
hist(subset_data$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")
dev.off()
png("plot2.png", width = 480, height = 480)
plot(subset_data$Datetime, subset_data$Global_active_power, 
     type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()
png("plot3.png", width = 480, height = 480)
plot(subset_data$Datetime, subset_data$Sub_metering_1, 
     type = "l", col = "black", xlab = "", 
     ylab = "Energy sub metering")
lines(subset_data$Datetime, subset_data$Sub_metering_2, col = "red")
lines(subset_data$Datetime, subset_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)
dev.off()
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# Top-left plot
plot(subset_data$Datetime, subset_data$Global_active_power, 
     type = "l", xlab = "", 
     ylab = "Global Active Power")

# Top-right plot
plot(subset_data$Datetime, subset_data$Voltage, 
     type = "l", xlab = "datetime", 
     ylab = "Voltage")

# Bottom-left plot
plot(subset_data$Datetime, subset_data$Sub_metering_1, 
     type = "l", col = "black", xlab = "", 
     ylab = "Energy sub metering")
lines(subset_data$Datetime, subset_data$Sub_metering_2, col = "red")
lines(subset_data$Datetime, subset_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")

# Bottom-right plot
plot(subset_data$Datetime, subset_data$Global_reactive_power, 
     type = "l", xlab = "datetime", 
     ylab = "Global Reactive Power")
dev.off()
