require(dplyr, quietly = TRUE)

#reading all dataset. read.csv2 uses ; as default separator
#setting colClasses to character to speed up reading
#we'll convert it to the desired class later
hpc <- read.csv2("household_power_consumption.txt", na.strings = "?", 
                 stringsAsFactors = FALSE, colClasses = rep("character", 9))

hpc$Date <- as.Date(hpc$Date, '%d/%m/%Y')

#filtering to said dates
hpc <- filter(hpc, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))

hpc$Global_active_power <- as.numeric(hpc$Global_active_power)

#the resulting file will appear in the working directory
png("plot1.png")
hist(hpc$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()