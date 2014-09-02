### Download, unzip and load dataset:

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
              'household_power_consumption.zip')
unzip('household_power_consumption.zip')
dataset <- read.table('household_power_consumption.txt', header = TRUE, sep = ';', na.strings = '?',
                      colClasses = c(rep('character', times = 2), rep('numeric', times =7)),
                      stringsAsFactors = FALSE)
dataset$Date <- as.Date(x = dataset$Date, format = '%d/%m/%Y', tz = 'GMT')


### Subset data from original dataset:

data3 <- subset(x = dataset, Date == '2007-02-01' | Date == '2007-02-02')
data3$Date <- paste(data3$Date, data3$Time)
data3$Time <- NULL
rownames(data3) <- NULL
data3$Date <- strptime(x = data3$Date, format = '%Y-%m-%d %H:%M:%S', tz = 'GMT')


### Make a plot and save it to PNG file:

Sys.setlocale('LC_TIME', 'English')
png(filename = 'plot3.png', width = 480, height = 480, bg = 'transparent')
plot(data3$Date, data3$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type='l')
lines(data3$Date, data3$Sub_metering_2, col = 'red')
lines(data3$Date, data3$Sub_metering_3, col = 'blue')
legend('topright', legend = names(data3)[6:8], col = c('black', 'red', 'blue'), lty = 1)
dev.off()