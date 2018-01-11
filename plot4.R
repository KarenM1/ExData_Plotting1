setwd("C:/Users/kmassey/datasciencecoursera/Exploratory Data Analysis")
library(dplyr)

###read the source text file as a data table ###
df <- read.table("C:/Users/kmassey/datasciencecoursera/Exploratory Data Analysis/household_power_consumption.txt", 
                 header = TRUE,sep=";",na.strings="?", stringsAsFactors = FALSE)

###filter out the subset of rows from Feb 1, 2007 and Feb 2, 2007
dfsub<-filter(df,Date=="1/2/2007"|Date=="2/2/2007")

### change Date to date format ##
dfsub$Date <- as.Date(dfsub$Date, format = "%d/%m/%Y")

### change Time to time format and concatenate date and time ##
dfsub$datetime<-format(as.POSIXct(paste(dfsub$Date,dfsub$Time)),"%d/%m/%Y %H:%M:%S")
### convert datetime from char to POSIXlt ###
dfsub$datetime <- strptime(dfsub$datetime, format='%d/%m/%Y %H:%M:%S')

### create plot4 ####
plot.new()
par(mfrow=c(2,2))
par(mar=c(4,4,1,1))
plot(dfsub$datetime,dfsub$Global_active_power, col="black", col.axis="black", type="l", 
     ylab = "Global Active Power", xlab="")
plot(dfsub$datetime,dfsub$Voltage,type="l", ylim = c(234,246),xlab = "datetime",ylab = "Voltage")
plot(dfsub$datetime,dfsub$Sub_metering_1,type="l", xlab="",ylab="Energy sub metering")
lines(dfsub$datetime,dfsub$Sub_metering_2,type="l", ylim = c(0,40), col="red")
lines(dfsub$datetime,dfsub$Sub_metering_3,type="l", ylim = c(0,40), col="blue")
legend( x="topright", 
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        col=c("black","red","blue"), lwd=1, lty=c(1,1,1))
plot(dfsub$datetime,dfsub$Global_reactive_power,type="l", ylim = c(0,0.5),xlab = "datetime",ylab = "Global_reactive_power")



### write plot4 to png ###
dev.copy(png,file="plot4.png",width = 480, height = 480)

### close the png device ###
dev.off()
