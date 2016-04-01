## Step 1: Read the data
## NOTE that the plot1.R should be in the same directory
## as the household_power_consumption.txt file!

## File has 2,075,259 rows with 7 numeric columns (8 bytes per numeric value)
## and 2 string columns (18 characters for both)
## Thus size is roughly (2075259*7*8+2075259*18) / 2^20 ~ 146 MBs.
## Should be plenty of room in memory to read in entire file and then
## filter.


hpcDF <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
                    colClasses = c('character', 'character', 'numeric',
                        'numeric', 'numeric', 'numeric', 'numeric', 'numeric',
                        'numeric'), na.strings = '?')


## Convert character date time columns into R Date object
hpcDF['DateTime'] <- paste(hpcDF$Date, hpcDF$Time, sep=' ')
hpcDF$DateTime <- strptime(hpcDF$DateTime, format="%d/%m/%Y %H:%M:%S")

## We only want to plot 2-day period so subset data

sDF <- subset(hpcDF, hpcDF$DateTime >=
                  strptime("2007-02-01", format = '%Y-%m-%d') &
                  hpcDF$DateTime < strptime('2007-02-03', format = '%Y-%m-%d'))

## Now it's time to create the actual plot



png('plot3.png', width=480, height=480, bg='transparent')
plot(sDF$DateTime, sDF$Sub_metering_1, type='l', xlab='',
     ylab='Energy sub metering', col='black')
lines(sDF$DateTime, sDF$Sub_metering_2, type='l', col='red')
lines(sDF$DateTime, sDF$Sub_metering_3, type='l', col='blue')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lwd=1, col = c('black', 'red', 'blue'))
dev.off()
