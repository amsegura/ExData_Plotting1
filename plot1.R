########### Plot 1 #####################

# Reading the data set
df <- read.table(unz("project_dataset.zip", 'household_power_consumption.txt'), header = TRUE, sep = ";")
df <- as_tibble(df)

# Selecting by dates
library(lubridate)
dates <- df %>% mutate(Date = dmy(Date)) %>% mutate(Time = hms(Time)) %>% 
        filter(Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02')) %>%
        mutate_if(is.character, as.numeric)
dates

# Histogram for plot1
with (dates, (hist(Global_active_power, col='red', 
                   xlab='Global Active Power (kilowatts)')))
dev.copy(png, file="plot1.png", width = 480, height = 480)
dev.off()
