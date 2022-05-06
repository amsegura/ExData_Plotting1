########### Plot 2 #####################

# Reading the data set
df <- read.table(unz("project_dataset.zip", 'household_power_consumption.txt'), header = TRUE, sep = ";")
df <- as_tibble(df)

# Selecting by dates and generating a Day column
library(lubridate)
dates <- df %>% mutate('Combine_date' = paste(Date, Time), .after = Time) %>%
        mutate(Combine_date = dmy_hms(Combine_date)) %>%
        mutate(Date = dmy(Date)) %>% mutate(Time = hms(Time)) %>% 
        filter(Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02')) %>%
        mutate_if(is.character, as.numeric) %>% mutate('Day' = weekdays(as.Date(Date))) 
        
dates


# Line plot for plot2
with (dates, (plot(x= Combine_date, y=Global_active_power, type='l', 
                   ylab='Global Active Power (kilowatts)', xlab="")))
dev.copy(png, file="plot2.png", width = 480, height = 480)
dev.off()