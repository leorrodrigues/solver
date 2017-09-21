df<- (read.table('somatorioProvedores.txt',sep=';',header=TRUE))

df

library(ggplot2) # for creating ggplot
library(ggthemes)
library(grid)

h<-ggplot(data=df,aes(x=Provedor,y=Quantidade,fill=Provedor))+
  ggtitle("Seleção dos provedores em relação\nA todos os cenários")+
  xlab("Quantidade de vezes selecionado")+
  ylab("Cenário")+
  theme_economist(base_size=9)+
  geom_bar(stat="identity",color="black")+
  geom_text(aes(label=Quantidade),vjust=-0.5,hjust=1.2,color="black")+
  scale_fill_manual(values=c("#ff9900", "#006600", "#6666FF","#ff1a1a"))+
  coord_flip()

h

png("somaProvedores.png")
print(h)
dev.off()

h<-ggplot(data=df,aes(x=Provedor,y=Media,fill=Provedor))+
  ggtitle("Média da seleção dos provedores em relação\nA todos os cenários")+
  xlab("Quantidade de vezes selecionado")+
  ylab("Cenário")+
  theme_economist(base_size=9)+
  geom_bar(stat="identity",color="black")+
  geom_text(aes(label=Media),vjust=-0.5,hjust=1.2,color="black")+
  scale_fill_manual(values=c("#ff9200", "#006600", "#6666FF","#f31a1a"))+
  coord_flip()

h

png("somaMediaProvedores.png")
print(h)
dev.off()