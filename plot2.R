library(datasets)
library(dplyr)
#Load Data
mydata <- read.csv("./household_power_consumption.txt",sep = ";")

#Add da time column genereated from Date and Time
mydata$DateTime <- strptime(paste(mydata$Date, mydata$Time, sep = " " ), format = "%d/%m/%Y %H:%M:%S")
#Parse string date column to DATE type
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

#Set start and end date variable to filter data
startdate <- as.Date("1/2/2007", "%d/%m/%Y") 
enddate <- as.Date("2/2/2007", "%d/%m/%Y")

#Filter Data based on date range
febdata <- mydata[ mydata$Date >= startdate & mydata$Date <= enddate,]
rm(mydata)


##Remove record that has ? 
febdata <- febdata[febdata$Global_active_power != '?',]
febdata$Global_active_power <- as.numeric(as.character(febdata$Global_active_power))

##Plot the graph
mainLable <- "Global Active Power"
histYLable <- "Global Active Power (killowatts)"

png(filename="plot2.png", width = 480, height = 480, units = "px")
with(febdata, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = histYLable))
#hist(febdata$Global_active_power,  main=mainLable, xlab = histXLable, col="red")
dev.off()

rm(febdata)