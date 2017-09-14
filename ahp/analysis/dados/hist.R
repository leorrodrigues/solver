df<- (read.table('dadosHisto.txt',header=TRUE,sep=';'))
df

library(ggplot2)

h<-ggplot(data=df,aes(x=Cenario,y=Selecao,fill=Provedor))+
  xlab("Cenários")+
  ylab("Frequência de Seleção")+
  geom_bar(stat="identity",position=position_dodge())+
  geom_text(aes(label=Selecao),vjust=1.6,color="white",position=position_dodge(0.9),size=3.5)+
  scale_fill_manual(values=c("#ff9900", "#006600", "#0000ff","#ff1a1a"))+
  theme(legend.position="top")

png("histograma.png")
print(h)
dev.off()