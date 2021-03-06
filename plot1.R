# EDA Assignment 1 Plot 1

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

# plot 1 histogram global active power
png(file="plot1.png")
plot1 <- hist(df$Global_active_power,main="Global Active Power",
      xlab="Global Active Power (kilowatts)",col="red")
dev.off()


