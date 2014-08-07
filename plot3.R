powerdata <- read.table("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE)
colnames(powerdata) <- powerdata[1, ]
powerdata <- powerdata[-1,]

## DATE FORMATTING!
library(lubridate)

powerdata$Date <- strptime(paste(powerdata$Date,powerdata$Time), 
                           "%d/%m/%Y %H:%M:%S")
subset1 <- subset(powerdata, Date == c("01/02/2007"))
subset2 <- subset(powerdata, Date == as.Date("2007-02-02"))
pd <- rbind(subset1, subset2)
pd$Global_active_power <- as.numeric(pd$Global_active_power)
pd$Global_reactive_power <- as.numeric(pd$Global_reactive_power)
pd$Voltage <- as.numeric(pd$Voltage)
pd$Global_intensity <- as.numeric(pd$Global_intensity)
pd$Sub_metering_1 <- as.numeric(pd$Sub_metering_1)
pd$Sub_metering_2 <- as.numeric(pd$Sub_metering_2)
pd$Sub_metering_3 <- as.numeric(pd$Sub_metering_3)
pd$comptime <- paste(pd$Date, pd$Time)
pd$comptime <- strptime(pd$comptime, "%Y-%m-%d %H:%M:%S")
##plot
png(filename ="plot3.png", width=480, height=480, units="px")
par(mfrow = c(1, 1), mar = c(5, 4, 4, 2), cex = c(0.77), lwd = c(1))
plot(pd$comptime, pd$Sub_metering_1, type = "s", 
     ylab="Energy sub metering", xlab ="")
lines(pd$comptime, pd$Sub_metering_2, col="red")
lines(pd$comptime, pd$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()