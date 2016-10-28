library(data.table)
new <- fread("power.txt", na.strings = "?")
new[,DateTime := as.Date(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
library(dplyr)
subset<-filter(new,DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-03 00:00:00"))
nrow(subset)
hist(subset$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power(kilowatts)")
dev.copy(png,'plot1.png',width=480,height=480)
dev.off()
