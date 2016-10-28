library(data.table)
data_full<-read.table("power.txt",header=T,sep=";",na.strings="?",nrows=2075259,stringsAsFactors = F)
data_full$Date<-as.Date(data_full$Date,format="%d/%m/%Y")

#subsetting the data
data<-subset(data_full,subset=(Date>="2007-02-01"&Date<="2007-02-02"))

#converting dates
datetime<-paste(as.Date(data$Date),data$Time)
data$Datetime<-as.POSIXct(datetime)

#converting Global_active_power,Global_reactive_power,Voltage,sub_metering_1,sub_metering_2 and sub_metering_3 to numeric
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power<-as.numeric(as.character(data$Global_reactive_power))
data$Voltage<-as.numeric(as.character(data$Voltage))
data$Sub_metering_1<-as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2<-as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3<-as.numeric(as.character(data$Sub_metering_3))

#creating plots
par(mfrow=c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(data$Global_active_power~data$Datetime,type="l",xlab="",ylab="Global Active Power")
 #plot 2 in row 1
plot(data$Voltage~data$Datetime,type="l",xlab="datetime",ylab="Voltage")

#plot 1 in row 2
plot(data$Sub_metering_1~data$Datetime,type="l",xlab="",ylab="Energy sub metering")
lines(data$Sub_metering_2~data$Datetime,type="l",col="red")
lines(data$Sub_metering_3~data$Datetime,type="l",col="blue")
legend("topright",lty=1,lwd=2,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#plot 2 in row 2
plot(data$Global_reactive_power~data$Datetime,type="l",xlab="datetime",ylab="Global_reactive_power")

#copying the plots
dev.copy(png,"plot4.png",height=480,width=480)
dev.off()
