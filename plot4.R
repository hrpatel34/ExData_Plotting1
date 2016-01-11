library(datasets)
library(dplyr)
##Load Data
mydata <- read.csv("./household_power_consumption.txt",sep = ";")

##Add date time column genereated from Date and Time
mydata$DateTime <- strptime(paste(mydata$Date, mydata$Time, sep = " " ), format = "%d/%m/%Y %H:%M:%S")
##Parse string date column to DATE type
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

##Set start and end date variable to filter data
startdate <- as.Date("1/2/2007", "%d/%m/%Y") 
enddate <- as.Date("2/2/2007", "%d/%m/%Y")

##Filter Data based on date range
febdata <- mydata[ mydata$Date >= startdate & mydata$Date <= enddate,]
rm(mydata)

##Plot the graph
png(filename="plot4.png", width = 480, height = 480, units = "px")

par(mfcol = c(2,2))

##PLOT 1
plotdata <- febdata[febdata$Global_active_power != '?',]
plotdata$Global_active_power <- as.numeric(as.character(plotdata$Global_active_power))
with(plotdata, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

##PLOT 2
##Plot blank graph
with(febdata, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
plotdata <- febdata[febdata$Sub_metering_3 != '?' & febdata$Sub_metering_2 != '?' & febdata$Sub_metering_3 != '?',]
plotdata$Sub_metering_1 <- as.numeric(as.character(plotdata$Sub_metering_1))
plotdata$Sub_metering_2 <- as.numeric(as.character(plotdata$Sub_metering_2))
plotdata$Sub_metering_3 <- as.numeric(as.character(plotdata$Sub_metering_3))


##add Sub_metering_1 to the graph
points(plotdata$DateTime, plotdata$Sub_metering_1, type = "l")
##add Sub_metering_2 to the graph
points(plotdata$DateTime, plotdata$Sub_metering_2, type = "l", col="red")
##add Sub_metering_3 to the graph
points(plotdata$DateTime, plotdata$Sub_metering_3, type = "l", col="blue")
##Add Legends
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd=1, pch=c(NA,NA,NA))


##PLOT 3
plotdata <- febdata[febdata$Voltage != '?',]
plotdata$Voltage <- as.numeric(as.character(plotdata$Voltage))
with(plotdata, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Valtage"))

##PLOT 4
plotdata <- febdata[febdata$Global_reactive_power != '?',]
plotdata$Global_reactive_power <- as.numeric(as.character(plotdata$Global_reactive_power))
with(plotdata, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))

#hist(febdata$Global_active_power,  main=mainLable, xlab = histXLable, col="red")
dev.off()

rm(plotdata)
rm(febdata)