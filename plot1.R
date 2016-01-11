library(datasets)

#Load Data
mydata <- read.csv("./household_power_consumption.txt",sep = ";")

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
histXLable <- "Global Active Power (killowatts)"

png(filename="plot1.png", width = 480, height = 480, units = "px")
hist(febdata$Global_active_power,  main=mainLable, xlab = histXLable, col="red")
dev.off()

rm(febdata)