########### Plot 4 #####################

# Loading required libraries
library(dplyr)
library(tibble)
library(lubridate)

# Reading the data set
df <- read.table(unz("project_dataset.zip", 'household_power_consumption.txt'), header = TRUE, sep = ";")
df <- as_tibble(df)

# Selecting by dates and generating a Day column and a Combine_date column
dates <- df %>% mutate('Combine_date' = paste(Date, Time), .after = Time) %>%
        mutate(Combine_date = dmy_hms(Combine_date)) %>%
        mutate(Date = dmy(Date)) %>% mutate(Time = hms(Time)) %>% 
        filter(Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02')) %>%
        mutate_if(is.character, as.numeric) %>% mutate('Day' = weekdays(as.Date(Date))) 

dates


#3 plots at once directly on png 
png(file="plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4, 4, 3, 1), oma = c(1, 1, 1, 1))
plot(x= dates$Combine_date, y=dates$Global_active_power, type='l', 
     ylab='Global Active Power', xlab="")

plot(x=dates$Combine_date, y=dates$Voltage, type='l', xlab = 'datetime',
     ylab = "Voltage")

plot(x= dates$Combine_date, y=dates$Sub_metering_1, type='l', 
     ylab='Energy sub metering', xlab="", col='black')
lines(x= dates$Combine_date, y=dates$Sub_metering_2, type='l',col='red')
lines(x= dates$Combine_date, y=dates$Sub_metering_3, type='l',col='blue')
legend("topright", lty=1:1, col=c("black", "red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), bty = 'n')

plot(x=dates$Combine_date, y=dates$Global_reactive_power, type='l', 
     xlab = 'datetime', ylab = "Global_reactive_power")

dev.off()