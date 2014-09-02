### Download, unzip and load dataset:

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
              'household_power_consumption.zip')
unzip('household_power_consumption.zip')
dataset <- read.table('household_power_consumption.txt', header = TRUE, sep = ';', na.strings = '?',
                      colClasses = c(rep('character', times = 2), rep('numeric', times =7)),
                      stringsAsFactors = FALSE)
dataset$Date <- as.Date(x = dataset$Date, format = '%d/%m/%Y', tz = 'GMT')


### Subset data from original dataset:

data2 <- subset(x = dataset, Date == '2007-02-01' | Date == '2007-02-02')
data2$Date <- paste(data2$Date, data2$Time)
data2$Time <- NULL
rownames(data2) <- NULL
data2$Date <- strptime(x = data2$Date, format = '%Y-%m-%d %H:%M:%S', tz = 'GMT')


### Make a plot and save it to PNG file:

Sys.setlocale('LC_TIME', 'English')
png(filename = 'plot2.png', width = 480, height = 480, bg = 'transparent')
plot(data2$Date, data2$Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')
dev.off()