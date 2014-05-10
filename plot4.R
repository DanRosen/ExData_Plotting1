# EDA Assignment 1 Plot 4

# Common code to read the file

setwd("C:\\Coursera\\EDA\\Week1\\repo")

# data is in "household_power_consumption.txt" but we want part of it
# dates between 2007-02-01 and 2007-02-02
file <- "household_power_consumption.txt"

header <- read.table(file, header = TRUE,sep=";",stringsAsFactors=FALSE,nrow=1)
nc <- ncol(header)
colDate <- read.table(file, header = TRUE, as.is = TRUE, sep=";", 
   colClasses = c(NA, rep("NULL", nc - 1)))
find1 <- grep("^1/2/2007|^2/2/2007",colDate$Date) # indices
start <- find1[1]
end   <- find1[length(find1)]
df <- read.table(file,header=FALSE,sep=";",stringsAsFactors=FALSE,
                  skip=start,nrow=length(find1))
names(df) <- names(header)
# convert date time
dt <- paste(df$Date,df$Time)
df$datetime <- strptime(dt,"%d/%m/%Y %T")
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# plot 4 2x2 plots reusing plots 2 and 3
png(file="plot4.png")
# fill plots by row
par(mfrow=c(2,2))
plot(df$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",
      xlab="",xaxt="n")
axis(1,labels=c("Thu","Fri","Sat"),at=c(0,1440,2880))

plot(df$Voltage,type="l",ylab="Voltage",xlab="datetime",xaxt="n")
axis(1,labels=c("Thu","Fri","Sat"),at=c(0,1440,2880))

plot(df$Sub_metering_1,ylab="Energy sub metering",xlab="",xaxt="n",type="l")
axis(1,labels=c("Thu","Fri","Sat"),at=c(0,1440,2880))
lines(df$Sub_metering_2,col="red")
lines(df$Sub_metering_3,col="blue")
legend("topright",names(df[7:9]),col=c("black","red","blue"),
         cex=.75,lty=1,bty="n",)

plot(df$Global_reactive_power,type="l",xlab="datetime",xaxt="n",
      ylab="Global_reactive_power",lwd=1)
axis(1,labels=c("Thu","Fri","Sat"),at=c(0,1440,2880))
dev.off()


