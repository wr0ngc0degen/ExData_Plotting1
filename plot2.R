require(dplyr, quietly = TRUE)
require(lubridate, quietly = TRUE)

#reading all dataset. read.csv2 uses ; as default separator
#setting colClasses to character to speed up reading
#we'll convert it to the desired class later
hpc <- read.csv2("household_power_consumption.txt", na.strings = "?", 
                 stringsAsFactors = FALSE, colClasses = rep("character", 9))

hpc$Date <- as.Date(hpc$Date, '%d/%m/%Y')

#filtering to said dates
hpc <- filter(hpc, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))

hpc$Global_active_power <- as.numeric(hpc$Global_active_power)

#adding a column with joint date
hpc <- mutate(hpc, DateTime = ymd_hms(paste(Date, Time)))

#the resulting file will appear in the working directory
png("plot2.png")
with(hpc, plot(DateTime, Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(hpc, lines(DateTime, Global_active_power))
dev.off()