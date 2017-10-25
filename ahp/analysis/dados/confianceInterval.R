df<- (read.table('dadosProvedor.txt',sep=';',header=TRUE))

df2<- (read.table('dadosHisto.txt',sep=";",header=TRUE))

df3<- (read.table('dadosProvedor2.txt',sep=";",header=TRUE))

m<-merge(df,df2,by.x=c("Cenario","Provedor"),by.y=c("Cenario","Provedor"))

m2<-merge(df2,df3,by.x=c("Cenario","Provedor"),by.y=c("Cenario","Provedor"))

summary(m2)

cd<-m2[m2$Cenario=="Comunicação de Dados",]
cu<-m2[m2$Cenario=="Custo",]
flat<-m2[m2$Cenario=="FLAT",]
pesq<-m2[m2$Cenario=="Pesquisa",]
qual<-m2[m2$Cenario=="Qualidade de Serviço Reservada",]
rede<-m2[m2$Cenario=="Rede",]
seg<-m2[m2$Cenario=="Segurança",]

errorT <- qt(0.975,df=length(m2$Selecao.y)-1)*sd(m2$Selecao.y)/sqrt(length(m2$Selecao.y))
errorT
errorCD <- qt(0.975,df=length(cd$Selecao.y)-1)*sd(cd$Selecao.y)/sqrt(length(cd$Selecao.y))
errorCD
errorCU <- qt(0.975,df=length(cu$Selecao.y)-1)*sd(cu$Selecao.y)/sqrt(length(cu$Selecao.y))
errorCU
errorFL <- qt(0.975,df=length(flat$Selecao.y)-1)*sd(flat$Selecao.y)/sqrt(length(flat$Selecao.y))
errorFL
errorPE <- qt(0.975,df=length(pesq$Selecao.y)-1)*sd(pesq$Selecao.y)/sqrt(length(pesq$Selecao.y))
errorPE
errorQU <- qt(0.975,df=length(qual$Selecao.y)-1)*sd(qual$Selecao.y)/sqrt(length(qual$Selecao.y))
errorQU
errorRE <- qt(0.975,df=length(rede$Selecao.y)-1)*sd(rede$Selecao.y)/sqrt(length(rede$Selecao.y))
errorRE
errorSE <- qt(0.975,df=length(seg$Selecao.y)-1)*sd(seg$Selecao.y)/sqrt(length(seg$Selecao.y))
errorSE

summary(cd$Selecao.y)
summary(cu$Selecao.y)
summary(flat$Selecao.y)
summary(pesq$Selecao.y)
summary(qual$Selecao.y)
summary(rede$Selecao.y)
summary(seg$Selecao.y)
