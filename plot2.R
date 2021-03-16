# download file and load Data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("Assignment")){
    dir.create("Assignment")
    download.file(url, destfile = "Assignment/power.zip", method = "curl")
}
unzip("Assignment/power.zip", exdir ="Assignment")
library(data.table)
power <- fread(file = "Assignment/household_power_consumption.txt",
               na.string = "?",
               col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
)
power <- power[Date == "1/2/2007"|Date=="2/2/2007"]

#plot2
library(lubridate)
power[, datetime := .(dmy(Date)+hms(Time))]
with(power, plot(datetime, Global_active_power, 
                 type = "l", 
                 ylab="Global Active Power (kilowatts)"
))
dev.copy(png, file = "Assignment/plot2.png")
dev.off()
