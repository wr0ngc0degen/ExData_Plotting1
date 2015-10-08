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

#adding a column with joint date
hpc <- mutate(hpc, DateTime = ymd_hms(paste(Date, Time)))

#converting the rest of the columns to numeric
hpc[3:9] <- sapply(hpc[3:9], as.numeric)

#the resulting file will appear in the working directory
png("plot3.png")
with(hpc, plot(DateTime, Sub_metering_1, type = "n", 
               ylab = "Energy sub metering", xlab = ""))
with(hpc, lines(DateTime, Sub_metering_1))
with(hpc, lines(DateTime, Sub_metering_2, col = "red"))
with(hpc, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), 
       legend = colnames(hpc)[7:9], lty = 1)
dev.off()