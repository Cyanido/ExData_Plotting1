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

#plot3
library(lubridate)
power[, datetime := .(dmy(Date)+hms(Time))]
with(power, plot(datetime, Sub_metering_1, 
                 type = "n", 
                 ylab="Energy sub metering"
))
with(power, points(x = datetime, y = Sub_metering_1, type = "l"))
with(power, points(x = datetime, y = Sub_metering_2, col= "red", type = "l"))
with(power, points(x = datetime, y = Sub_metering_3, col= "blue", type = "l"))
legend("topright",
       legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col= c("black", "red","blue"),
       lty = "solid"
)
dev.copy(png, file = "Assignment/plot3.png")
dev.off()