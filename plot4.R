# Plot 4
# read in "household_power_consumption.txt"
# filter date range 01/02/2007 to 02/02/2007
# create four charts
# save plot to PNG file
# J.B. Cheney. 8-Nov-2015


## read in all the data
power <- read.table("household_power_consumption.txt",sep=";",header=TRUE,
                    stringsAsFactors=FALSE)
# Filter on date range
power <- power[power$Date %in% c( "1/2/2007", "2/2/2007"),]

# Coerce the numeric data
power[,3:9] = apply(power[,3:9], 2, function(x) as.numeric(as.character(x)))

# Create combined Date / Time variable
powerTime <- paste( power$Date, power$Time )
power$DateTime <- strptime(powerTime, format = "%d/%m/%Y %H:%M:%S")
rm(powerTime)

par(mfrow = c(2,2))
with(power, {
  # Plot[1,1] 
  plot(power$DateTime, power$Global_active_power, 
       type = "l",xlab = "",ylab = "Global Active Power (kilowatts)")
  # Plot[1,2]
  plot(power$DateTime, power$Voltage, 
       type = "l",xlab = "",ylab = "Voltage")
  
  # Plot[2,1]
  plot(power$DateTime, power$Sub_metering_1, 
       type = "n",xlab = "",ylab = "Energy sub metering")
    # Add lines
    lines(power$DateTime,power$Sub_metering_1,col="black")
    lines(power$DateTime,power$Sub_metering_2,col="red")
    lines(power$DateTime,power$Sub_metering_3,col="blue")
  
    legend("topright",lty=c(1,1,1),col=c("black","red","blue"), 
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  # Plot[2,2]
  plot(power$DateTime, power$Global_reactive_power, 
       type = "l",xlab = "",ylab = "Global Reactive Power (kilowatts)")
  
})
## Save it to png
dev.copy(png,"plot4.png",width=480,height=480,units="px")
dev.off()
