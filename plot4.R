#### Coursera - Data Science Specialization Course
#### "Exploratory Data Analysis" - Week 1 -> Project 1 -> Plot 4
#### Date: 7 Nov 2014
#### Author: Ashish Rane

######### Load the required library #########

library(data.table)

######### Load the zip file #########

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "household_power_consumption"
download.file(url, file, method = "curl")

#Unzip the downloaded zip file & read the file "household_power_consumption.txt" to a data frame

epc <- fread("household_power_consumption.txt")

######### Clean the data #########

# Check the class of Date and time variables 
class(epc$Date)
class(epc$Time)
#Data and time variables are characters

# Change the format of Date variable
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")

## Check the class of Date variable again
class(epc$Date)

# Fetch the required data
epc_subset <- epc[epc$Date=="2007-02-01" | epc$Date=="2007-02-02"]

# Convert the fetched subset to a data frame
epc_subset <- data.frame(epc_subset)


# Convert all the columns (except Date and Time column) to numeric 
for(i in c(3:9)) {epc_subset[,i] <- as.numeric(as.character(epc_subset[,i]))}

# Create Date_Time variable
epc_subset$Date_Time <- paste(epc_subset$Date, epc_subset$Time)

# Convert Date_Time variable to proper format
epc_subset$Date_Time <- strptime(epc_subset$Date_Time, format="%Y-%m-%d %H:%M:%S")


######### Create Plot 4 & save it to a PNG file #########

png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

par(mfrow = c(2,2), mar = c(14,6,2,2), cex=0.5)

plot(epc_subset$Date_Time, epc_subset$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n", xaxt = NULL)
lines(epc_subset$Date_Time, epc_subset$Global_active_power, type="S")

plot(epc_subset$Date_Time, epc_subset$Voltage, xlab = "datetime", ylab = "Voltage", type = "n", xaxt = NULL)
lines(epc_subset$Date_Time, epc_subset$Voltage, type="S")

plot(epc_subset$Date_Time, epc_subset$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n", xaxt = NULL)
lines(epc_subset$Date_Time, epc_subset$Sub_metering_1, col = "black", type="S")
lines(epc_subset$Date_Time, epc_subset$Sub_metering_2, col = "red", type="S")
lines(epc_subset$Date_Time, epc_subset$Sub_metering_3, col = "blue", type="S")
legend("topright", lty = c(1,1), lwd = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(epc_subset$Date_Time, epc_subset$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n", xaxt = NULL)
lines(epc_subset$Date_Time, epc_subset$Global_reactive_power, type="S")

dev.off()

######### End of script #########



