df<- (read.table('dadosHisto.txt',header=TRUE,sep=';'))
df

library(ggplot2)

h<-ggplot(data=df,aes(x=Cenario,y=Selecao,fill=Provedor))+
  ggtitle("Desempenho das alternativas em relação ao cenário")+
  xlab("Cenários")+
  ylab("Frequência de Seleção")+
  theme_economist(base_size=9)+
  geom_bar(stat="identity",color="black",position=position_dodge())+
  geom_text(aes(label=Selecao),vjust=-0.5,color="black",position=position_dodge(0.9),size=3.0,rotate=45)+
  scale_fill_manual(values=c("#ff9900", "#006600", "#0000ff","#ff1a1a"))+
  theme(legend.position="top",axis.text.x = element_text(angle = 90, hjust = 1))
h

png("histograma.png")
print(h)
dev.off()