# Plot 1
# read in "household_power_consumption.txt"
# filter date range 01/02/2007 to 02/02/2007
# create a histogram of Global Active Power
# save plot to PNG file
# J.B. Cheney. 8-Nov-2015

## read in all the data
power <- read.table("household_power_consumption.txt",sep=";",header=TRUE,
                    stringsAsFactors=FALSE)
## Filter on date range
power <- power[power$Date %in% c( "1/2/2007", "2/2/2007"),]

## Coerce the numeric data
power[,3:9] = apply(power[,3:9], 2, function(x) as.numeric(as.character(x)))
## Convert 'Date' to date type
power$Date=strptime(power$Date, format="%d/%m/%Y")


## Create histogram of Global Active Power
hist(power$Global_active_power, col="red",xlab="Global Active Power (kilowats)",
     main = "Global Active Power" )

## Save it to png
dev.copy(png,"plot1.png",width=480,height=480,units="px",res=100)
dev.off()


