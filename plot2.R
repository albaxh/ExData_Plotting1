#########################################################################################
# Exploratory Data Analysis - Course Project 1                                          #
#                                                                                       #
# This assignment uses data from the UC Irvine Machine Learning Repository,             #
# a popular repository for machine learning datasets. In particular, we will be using   # 
# the “Individual household electric power consumption Data Set” which is been made     #
# available on the course web site:                                                     #
# Dataset:                                                                              #
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip #     
# [20Mb]                                                                                #
# Description: Measurements of electric power consumption in one household with a       # 
# one-minute sampling rate over a period of almost 4 years. Different electrical        #
# quantities and some sub-metering values are available.                                #
#########################################################################################


## Loading data

# Dataset url and file name
datasetUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datasetFile <- "exdata_data_household_power_consumption.zip"
dataPath <- "household_power_consumption.txt"

# Only download and unzip file if not done before
if (!file.exists(datasetFile)) {
    download.file(datasetUrl, datasetFile, mode = "wb")
}
if (!file.exists(dataPath)) {
    unzip(datasetFile)
}

# Read houshold power consumption data from the dates 2007-02-01 and 2007-02-02.
hhpc <- read.table(dataPath, skip = 1, sep = ";", stringsAsFactors = FALSE)

# Set column names
names(hhpc) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Subset data for dates between 1/2/2007-2/2/2007
hhpc <- subset(hhpc, hhpc$Date=="1/2/2007" | hhpc$Date =="2/2/2007")

hhpc$Date <- as.Date(hhpc$Date, format="%d/%m/%Y")
hhpc$Time <- strptime(hhpc$Time, format="%H:%M:%S")
hhpc[1:1440,"Time"] <- format(hhpc[1:1440,"Time"],"2007-02-01 %H:%M:%S")
hhpc[1441:2880,"Time"] <- format(hhpc[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# Create png file
png("plot2.png", width = 480, height = 480)

# Draw plot
plot(hhpc$Time,as.numeric(hhpc$Global_active_power),type="l",xlab="",ylab="Global Active Power (kilowatts)") 
title(main="Global Active Power Vs Time")

# Finish
dev.off()