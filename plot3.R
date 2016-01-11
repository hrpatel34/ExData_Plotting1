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

##Remove record that has ? 
#febdata <- febdata[febdata$Global_active_power != '?',]
#febdata <- febdata[febdata$Sub_metering_1 != '?',]
#febdata <- febdata[febdata$Sub_metering_2 != '?',]
#febdata <- febdata[febdata$Sub_metering_3 != '?',]
febdata <- febdata[febdata$Sub_metering_3 != '?' & febdata$Sub_metering_2 != '?' & febdata$Sub_metering_3 != '?',]
#& febdata$Sub_metering_2 != '?' & febdata$Sub_metering_3 != '?'
#febdata$Global_active_power <- as.numeric(as.character(febdata$Global_active_power))
febdata$Sub_metering_1 <- as.numeric(as.character(febdata$Sub_metering_1))
febdata$Sub_metering_2 <- as.numeric(as.character(febdata$Sub_metering_2))
febdata$Sub_metering_3 <- as.numeric(as.character(febdata$Sub_metering_3))
##Plot the graph
#mainLable <- "Global Active Power"
histYLable <- "Energy Sub Metering"

png(filename="plot3.png", width = 480, height = 480, units = "px")
##Plot blank graph
with(febdata, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = histYLable))
##add Sub_metering_1 to the graph
points(febdata$DateTime, febdata$Sub_metering_1, type = "l")
##add Sub_metering_2 to the graph
points(febdata$DateTime, febdata$Sub_metering_2, type = "l", col="red")
##add Sub_metering_3 to the graph
points(febdata$DateTime, febdata$Sub_metering_3, type = "l", col="blue")
##Add Legends
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd=1, pch=c(NA,NA,NA))

#hist(febdata$Global_active_power,  main=mainLable, xlab = histXLable, col="red")
dev.off()
