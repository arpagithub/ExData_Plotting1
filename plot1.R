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

## Creating Plot1 and saving the PNG file ####

## 1. Open PNG file
png("plot1.png"
    ,width = 480
    ,height = 480)

## 2. Create the plot
hist(electric_power_raw$Global_active_power
     ,col = "red"
     ,main = "Global Active Power"
     ,xlab = "Global Active Power (kilowatts)"
     ,ylab = "Frequency"
)

## 3. Close the file
dev.off()