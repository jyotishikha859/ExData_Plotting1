library(data.table)
data_full<-read.table("power.txt",header=T,sep=";",na.strings="?",nrows=2075259,stringsAsFactors = F)
data_full$Date<-as.Date(data_full$Date,format="%d/%m/%Y")

#subsetting the data
data<-subset(data_full,subset=(Date>="2007-02-01"&Date<="2007-02-02"))

#converting dates
datetime<-paste(as.Date(data$Date),data$Time)
data$Datetime<-as.POSIXct(datetime)

#converting sub_metering_1,sub_metering_2 and sub_metering_3 to numeric
data$Sub_metering_1<-as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2<-as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3<-as.numeric(as.character(data$Sub_metering_3))

#creating plot
plot(data$Sub_metering_1~data$Datetime,type="l",xlab="",ylab="Energy sub metering")
#adds line graph
lines(data$Sub_metering_2~data$Datetime,type="l",col="red")
lines(data$Sub_metering_3~data$Datetime,type="l",col="blue")

#adds legend to the graph
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#saving the graph
dev.copy(png,"plot3.png",height=480,width=480)
dev.off()
