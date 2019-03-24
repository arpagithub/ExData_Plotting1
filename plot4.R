##Exploratory Data Analysis Wk1 Assignment

##Defining Library for the program
library(dplyr)
library(tidyr)
library(plyr)
library(lubridate)


##clean up R memory before executing the code
rm(list=ls())

## Set Working Directory
setwd("/Users/arpanharit/Documents/Coursera/4/Wk1/")

## Unzip File
zipfile <- "exdata_data_household_power_consumption.zip"
unzip(zipfile, overwrite = TRUE)
rm("zipfile")

## Read full data
electric_power_raw <- read.csv2("./household_power_consumption.txt"
                                ,header = TRUE
                                ,sep = ";"
                                ,na.strings = "?"
                                ,blank.lines.skip = TRUE
                                ,stringsAsFactors=FALSE)

##filter data for the two dates
electric_power_raw <- electric_power_raw[electric_power_raw$Date %in% c("1/2/2007","2/2/2007"),] 

## converting class of the column
electric_power_raw$Date <- as.Date(electric_power_raw$Date,"%d/%m/%Y")
electric_power_raw[,c(3:9)] = apply(electric_power_raw[,c(3:9)], 2, function(x) as.numeric(as.character(x)))

## create new column datetime and store date and time to it
electric_power_raw$datetime <- as.POSIXct(paste(electric_power_raw$Date,electric_power_raw$Time)
                                          ,format = "%Y-%m-%d %H:%M:%S")

##End of Sourcing of data code###

## Creating Plot4 and saving the PNG file ####

## 1. Open PNG file
png("plot4.png"
    ,width = 480
    ,height = 480)

## 2. Define quadrants using the pch function
par(mfrow=c(2,2))

## 3. Create the plot

## 3.1. Create the plot for Global Active Power
plot(electric_power_raw$datetime
     ,electric_power_raw$Global_active_power
     ,type = "l"
     ,xlab = ""
     ,ylab = "Global Active Power"
)

## 3.2. Create the plot for Voltage
plot(electric_power_raw$datetime
     ,electric_power_raw$Voltage
     ,type = "l"
     ,xlab = "datetime"
     ,ylab = "Voltage"
)

## 3.3. Create the plot for Energy sub metering

##3.3.a.first create a new plot for sub metering 1
plot(electric_power_raw$datetime,
     electric_power_raw$Sub_metering_1
     ,type = "l"
     ,col="black"
     ,xlab = ""
     ,ylab = "Energy sub metering"
)
##3.3.b.add lines for sub_meetering 2
lines(electric_power_raw$datetime,
      electric_power_raw$Sub_metering_2
      ,type = "l"
      ,col="red"
)
##3.3.c.add lines for sub_meetering 3
lines(electric_power_raw$datetime,
      electric_power_raw$Sub_metering_3
      ,type = "l"
      ,col="blue"
)

## add legend on the topright. Use PCH equal to 95 for the line
legend("topright", pch = 95, col = c("black","red", "blue")
       , legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,box.lty = 0
       ,lwd=2
       ,lty = 1)

## 3.4. Create the plot for Global Reactive Power
plot(electric_power_raw$datetime
     ,electric_power_raw$Global_reactive_power
     ,type = "l"
     ,xlab = "datetime"
     ,ylab = "Global_reactive_power"
)

## 4. Close the file
dev.off()