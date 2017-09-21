library(ggplot2) # for creating ggplot
library(ggthemes)
library(grid)

df<- (read.table('dadosProvedor.txt',sep=';',header=TRUE))

df2<- (read.table('dadosHisto.txt',sep=";",header=TRUE))

df3<- (read.table('dadosProvedor2.txt',sep=";",header=TRUE))

m<-merge(df,df2,by.x=c("Cenario","Provedor"),by.y=c("Cenario","Provedor"))

p<- ggplot(m, aes(x=Cenario, y=Média, fill=Provedor)) +
  ggtitle("Desvio padrão das alternativas em relação\nAo cenário")+
  geom_bar(stat="identity", color="black",position=position_dodge()) +
  xlab("Cenários")+
  ylab("Valor de Ranqueamento")+
  #geom_text(aes(label=Média),vjust=-0.5,color="black",position=position_dodge(0.9),size=3.0)+
  theme_economist()+
  scale_fill_manual(values=c("#ff9900", "#006600", "#0000ff","#ff1a1a"))+
  theme(legend.position="top",axis.text.x = element_text(angle = 90, hjust = 1))+
  geom_errorbar(aes(ymin=Média-Desvio.Padrão, ymax=Média+Desvio.Padrão), width=.2,position=position_dodge(.9)) 

p

png("desvioBar.png")
print(p)
dev.off()

m2<-merge(df2,df3,by.x=c("Cenario","Provedor"),by.y=c("Cenario","Provedor"))

p2<- ggplot(m2, aes(x=Cenario, y=Selecao.y, fill=Provedor)) +
  ggtitle("Desvio padrão das alternativas em relação\nAo cenário")+
  #geom_bar(stat="identity", color="black",position=position_dodge()) +
  geom_boxplot(color="black",outlier.shape=NA)+
  xlab("Cenários")+
  ylab("Valor de Ranqueamento")+
  theme_economist()+
  coord_cartesian(ylim = c(0.22, 0.28)) +
  #geom_text(aes(label=Média),vjust=-0.5,color="black",position=position_dodge(0.9),size=3.0)+
  scale_fill_manual(values=c("#ff9900", "#006600", "#0000ff","#ff1a1a"))+
  theme(legend.position="top",axis.text.x = element_text(angle = 90, hjust = 1))
  #geom_errorbar(aes(ymin=Selecao.y-Desvio.Padrão, ymax=Selecao.y+Desvio.Padrão), width=.2,position=position_dodge(.9))
  
p2

png("desvioBox.png")
print(p2)
dev.off()