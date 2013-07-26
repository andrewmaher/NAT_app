library(gdata)
library(data.table)
library(plyr)

df.recp <- read.xls('./data/NAT data roodman.xls', sheet=2,stringsAsFactors=F)
df.recp[,'target'] <- df.recp[,'Recipient.name']
df.recp[which(duplicated(df.recp[,'target'])),'target'] <- paste(df.recp[which(duplicated(df.recp[,'target'])),'target'],'(2)')
df.recp <- df.recp[,c('Recipient.code','target')]
colnames(df.recp) <- c('recipient_name','target')
df.donor <- read.xls('./data/NAT data roodman.xls', sheet=3,stringsAsFactors=F)
colnames(df.donor) <- c('donor_name','source')

dt <- fread('./data/NAT by donor, recipient, year, data type.csv',stringsAsFactors=F)
dt <- data.table(dt,check.names=T)
dt <- dt[data.type=='D',]
dt <- dt[,list(Year,recipient_name,donor_name,NAT)]
dt$NAT <- as.numeric(dt$NAT)*1000000

dt <- join(dt,df.recp,by='recipient_name')
dt <- join(dt,df.donor,by='donor_name')
dt <- dt[,list(Year,source,target,NAT)]
dt <- dt[NAT!=0,]

dt <- dt[!is.na(Year),]
dt <- dt[!is.na(source),]
dt <- dt[!is.na(target),]
dt <- dt[!is.na(NAT),]

write.csv(dt,'./data/edge_list.csv',row.names=F)