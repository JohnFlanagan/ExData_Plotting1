powerdata <- read.table("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE)
colnames(powerdata) <- powerdata[1, ]
powerdata <- powerdata[-1,]

## DATE FORMATTING!
library(lubridate)
y <- as.Date(powerdata$Date, format = "%d/%m/%Y")
powerdata$Date <- y
subset1 <- subset(powerdata, Date == as.Date("2007-02-01"))
subset2 <- subset(powerdata, Date == as.Date("2007-02-02"))
pd <- rbind(subset1, subset2)
pd$Global_active_power <- as.numeric(pd$Global_active_power)
pd$Global_reactive_power <- as.numeric(pd$Global_reactive_power)
pd$Voltage <- as.numeric(pd$Voltage)
pd$Global_intensity <- as.numeric(pd$Global_intensity)
pd$Sub_metering_1 <- as.numeric(pd$Sub_metering_1)
pd$Sub_metering_2 <- as.numeric(pd$Sub_metering_2)
pd$Sub_metering_3 <- as.numeric(pd$Sub_metering_3)
library(chron)
aa <- chron(times=pd$Time)
pd$Time <- aa

##plot
png(filename ="plot1.png", width=480, height=480, units="px")
par(mfrow = c(1, 1), mar = c(5, 4, 4, 2), cex = c(0.77), lwd = c(1))
hist(pd$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="red")
dev.off()