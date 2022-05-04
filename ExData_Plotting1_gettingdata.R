########### Exploring Data plotting project 1 #####################

# Loading required libraries
library(dplyr)
library(tibble)

# Getting the data set
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./project_dataset.zip", method='curl')

# Reading the data set
df <- read.table(unz("project_dataset.zip", 'household_power_consumption.txt'), header = TRUE, sep = ";")
df <- as_tibble(df)
df