mydata <- read.table('combine.txt',header = F,sep = ',')

mydata$date=as.Date(as.POSIXct(as.numeric(mydata$V1),origin="1970-01-01", tz="GMT"))


datelist=seq(from=as.Date("1997/11/07"),to=as.Date("2012/10/16"), length.out = 500)



ishelpful=as.numeric(gsub(pattern='(\\d+)/(\\d+)',x=as.character(mydata$V2),replacement='\\1'))
allclick=as.numeric(gsub(pattern='(\\d+)/(\\d+)',x=as.character(mydata$V2),replacement='\\2'))



summary_y=numeric(length(datelist))
text_y=numeric(length(datelist))
score_y=numeric(length(datelist))
ishelpful_y=numeric(length(datelist))
allclick_y=numeric(length(datelist))

for (i in 1:length(datelist)){
  centerdate=datelist[i]
  neededdate=(difftime(strptime(centerdate,format = "%Y-%m-%d"),strptime(mydata$date,format = "%Y-%m-%d"),units="days")<=15)
  summary_y[i]=mean(mydata[neededdate,5])
  text_y[i]=mean(mydata[neededdate,4])
  score_y[i]=mean(mydata[neededdate,3])
  ishelpful_y[i]=mean(ishelpful[neededdate])
  allclick_y[i]=mean(allclick[neededdate])
}

write.table(data.frame(datelist,summary_y,text_y,score_y,ishelpful_y,allclick_y),file='500data.csv',sep=',',row.names = FALSE)


plotdata=read.csv('500data.csv',header = T)

neededlable=plotdata$datelist[round(seq(1,500,length.out = 50))]


plot(x=1:500,col='#145b7d',ylim = c(4.65,4.85),y=plotdata$summary_y,bty='n',type='l',yaxt='n',xaxt='n',
     lwd=2,xlab='',ylab = 'number of words in summary',main = 'Summary VS Time')

abline(h=c(4.65,4.7,4.75,4.8,4.85),col='gray')
axis(1,at=seq(1,500,length.out = 50),labels = neededlable,las=3)
axis(2,at=c(4.65,4.7,4.75,4.8,4.85),labels = c(4.65,4.70,4.75,4.80,4.85))
abline(lty=3,v=seq(1,500,length.out = 50)[which(neededlable %in% c('2005-02-26','2010-01-13','2007-01-05'))],col='#FF4040')




plot(x=1:500,col='#145b7d',ylim = c(138,154),y=plotdata$text_y,bty='n',type='l',yaxt='n',xaxt='n',
     lwd=2,xlab='',ylab = 'number of words in text',main = 'Text VS Time')

abline(h=c(138,142,146,150,154),col='gray')
axis(1,at=seq(1,500,length.out = 50),labels = neededlable,las=3)
axis(2,at=c(138,142,146,150,154),labels = c(138,142,146,150,154))
abline(lty=3,v=seq(1,500,length.out = 50)[which(neededlable %in% c('2004-04-04','2007-01-05','2012-03-11'))],col='#FF4040')


plot(x=1:500,col='#145b7d',ylim = c(3.95,4.15),y=plotdata$score_y,bty='n',type='l',yaxt='n',xaxt='n',
     lwd=2,xlab='',ylab = 'Score',main = 'Score VS Time')

abline(h=c(3.95,4.00,4.05,4.10,4.15),col='gray')
axis(1,at=seq(1,500,length.out = 50),labels = neededlable,las=3)
axis(2,at=c(3.95,4.00,4.05,4.10,4.15),labels = c(3.95,4.00,4.05,4.10,4.15))
abline(lty=3,v=seq(1,500,length.out = 50)[which(neededlable %in% c('2007-01-05','2012-03-11'))],col='#FF4040')



plot(x=1:500,y=plotdata$ishelpful_y)
plot(x=1:500,y=plotdata$allclick_y)

plot(x=1:500,y=plotdata$ishelpful_y/sqrt(plotdata$allclick_y))
     
plot(x=1:500,col='#145b7d',ylim = c(0.60,0.76),y=plotdata$ishelpful_y/plotdata$allclick_y,bty='n',type='l',yaxt='n',xaxt='n',
     lwd=2,xlab='',ylab = 'Helpful/Total Click',main = 'Ratio VS Time')

abline(h=c(0.60,0.64,0.68,0.72,0.76),col='gray')
axis(1,at=seq(1,500,length.out = 50),labels = neededlable,las=3)
axis(2,at=c(0.60,0.64,0.68,0.72,0.76),labels = c(0.60,0.64,0.68,0.72,0.76))
abline(lty=3,v=seq(1,500,length.out = 50)[which(neededlable %in% c('2007-01-05','2012-03-11'))],col='#FF4040')


plot(x=1:500,col='#145b7d',ylim = c(0.80,2.0),y=plotdata$ishelpful_y/sqrt(plotdata$allclick_y),bty='n',type='l',yaxt='n',xaxt='n',
     lwd=2,xlab='',ylab = 'Helpful/Total Click',main = 'Ratio VS Time')

abline(h=c(0.80,1.20,1.60,2.00),col='gray')
axis(1,at=seq(1,500,length.out = 50),labels = neededlable,las=3)
axis(2,at=c(0.80,1.20,1.60,2.00),labels = c(0.80,1.20,1.60,2.00))
abline(lty=3,v=seq(1,500,length.out = 50)[which(neededlable %in% c('2004-11-08','2011-07-25'))],col='#FF4040')














