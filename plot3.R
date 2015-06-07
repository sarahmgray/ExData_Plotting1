if (!file.exists("./exdata_data_household_power_consumption/household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./exdata_data_household_power_consumption.zip")
        unzip("./exdata_data_household_power_consumption.zip", overwrite = T)
} ## If the file does not exist, it is downloaded and placed in the top directory
data <- read.table("./household_power_consumption.txt", header=T, sep=';') ## read the file
data$Date <- as.Date(data$Date, format="%d/%m/%Y") ## Format date data
df <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),] ## place records for target date sequence in a dataframe
df$Global_active_power <- as.numeric(as.character(df$Global_active_power)) ## Change format of Global_active_power
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power)) ## Change format of Global_reactive_power
df$Voltage <- as.numeric(as.character(df$Voltage)) ## Change format of Voltage
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:$S") ##reformat as timestamps
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1)) ## change format for Sub_metering_1
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2)) ## change format for Sub_metering_2
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3)) ## change format for Sub_metering_3
plot3 <- function() {
       plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
       lines(df$timestamp,df$Sub_metering_2,col="red")
       lines(df$timestamp,df$Sub_metering_3,col="blue")
       legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
       dev.copy(png, file="plot3.png", width=480, height=480)
       dev.off()
       }
plot3()