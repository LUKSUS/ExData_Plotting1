### Download, unzip and load dataset:

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
              'household_power_consumption.zip')
unzip('household_power_consumption.zip')
dataset <- read.table('household_power_consumption.txt', header = TRUE, sep = ';', na.strings = '?',
                      colClasses = c(rep('character', times = 2), rep('numeric', times =7)),
                      stringsAsFactors = FALSE)
dataset$Date <- as.Date(x = dataset$Date, format = '%d/%m/%Y', tz = 'GMT')


### Subset data from original dataset:

data4 <- subset(x = dataset, Date == '2007-02-01' | Date == '2007-02-02')
data4$Date <- paste(data4$Date, data4$Time)
data4$Time <- NULL
rownames(data4) <- NULL
data4$Date <- strptime(x = data4$Date, format = '%Y-%m-%d %H:%M:%S', tz = 'GMT')


### Make a plot and save it to PNG file:

Sys.setlocale('LC_TIME', 'English')
png(filename = 'plot4.png', width = 480, height = 480, bg = 'transparent')
par(mfrow = c(2,2))
plot(data4$Date, data4$Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power')
plot(data4$Date, data4$Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage')
plot(data4$Date, data4$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type='l')
lines(data4$Date, data4$Sub_metering_2, col = 'red')
lines(data4$Date, data4$Sub_metering_3, col = 'blue')
legend('topright', legend = names(data4)[6:8], col = c('black', 'red', 'blue'), lty = 1, bty = 'n')
plot(data4$Date, data4$Global_reactive_power, type = 'l', xlab = 'datetime', ylab = 'Global Reactive Power')
dev.off()