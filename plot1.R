### Download, unzip and load dataset:

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
              'household_power_consumption.zip')
unzip('household_power_consumption.zip')
dataset <- read.table('household_power_consumption.txt', header = TRUE, sep = ';', na.strings = '?',
                      colClasses = c(rep('character', times = 2), rep('numeric', times =7)),
                      stringsAsFactors = FALSE)
dataset$Date <- as.Date(x = dataset$Date, format = '%d/%m/%Y', tz = 'GMT')


### Subset data from original dataset:

data1 <- subset(x = dataset, Date == '2007-02-01' | Date == '2007-02-02')
data1$Date <- paste(data1$Date, data1$Time)
data1$Time <- NULL
rownames(data1) <- NULL
data1$Date <- strptime(x = data1$Date, format = '%Y-%m-%d %H:%M:%S', tz = 'GMT')


### Make a plot and save it to PNG file:

png(filename = 'plot1.png', width = 480, height = 480, bg = 'transparent')
hist(x = data1$Global_active_power, main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', col='red')
dev.off()