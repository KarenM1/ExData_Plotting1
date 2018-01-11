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

### create plot2 ####
plot(dfsub$datetime,dfsub$Global_active_power, col="black", col.axis="black", type="l", 
     ylab = "Global Active Power (kilowatts)", xlab="")

### write plot2 to png ###
dev.copy(png,file="plot2.png", width = 480, height = 480)

### close the png device ###
dev.off()
