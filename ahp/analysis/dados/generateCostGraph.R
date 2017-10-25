df<- (read.table('dadosCusto2.txt',header=TRUE,sep=';'))
df

library(ggplot2)
library("ggthemes")

h<-ggplot(data=df,aes(x=Cenario,y=Percentagem.Custo.Cenário,fill=Provedor))+
  ggtitle("Cenários/Custos\nSeleção de provedores")+
  xlab("Cenários")+
  ylab("Frequência de Seleção")+
  theme_economist(base_size=9)+
  geom_bar(stat="identity",color="black",position=position_dodge())+
  scale_fill_manual(values=c("#ff9900", "#006600", "#0000ff","#ff1a1a"))+
  theme(legend.position="top",axis.text.x = element_text(angle = 90, hjust = 1))
h

png("custoXcenario2.png")
print(h)
dev.off()
pdf("custoXcenario2.pdf")
print(h)
dev.off()

df<- (read.table('dadosCusto.txt',header=TRUE,sep=';'))
df

library(ggplot2)
library("ggthemes")

h<-ggplot(data=df,aes(x=Cenario,y=Percentagem.Custo.Cenário,fill=Provedor))+
  ggtitle("Cenários/Custos\nSeleção de provedores")+
  xlab("Cenários")+
  ylab("Frequência de Seleção")+
  theme_economist(base_size=9)+
  geom_bar(stat="identity",color="black",position=position_dodge())+
  scale_fill_manual(values=c("#ff9900", "#006600", "#0000ff","#ff1a1a"))+
  theme(legend.position="top",axis.text.x = element_text(angle = 90, hjust = 1))
h

png("custoXcenario.png")
print(h)
dev.off()
pdf("custoXcenario.pdf")
print(h)
dev.off()
