df<- (read.table('temposQntProvedores.txt',sep=';',header=TRUE))
df

library(ggplot2) # for creating ggplot
library(ggthemes)

p<- ggplot(df, aes(x=Quantidade, y=Tempo)) +
  ggtitle("Tempo computacional em relação a\nQuantidade de provedores de nuvem")+
  geom_line() +
  geom_point()+
  xlab("Quantidade de Provedores")+
  ylab("Tempo(ms)")+
  #geom_text(aes(label=Média),vjust=-0.5,color="black",position=position_dodge(0.9),size=3.0)+
  theme_economist()

p

png("tempoProvedoresMS.png")
print(p)
dev.off()

p2<- ggplot(df, aes(x=Quantidade, y=MS)) +
  ggtitle("Tempo computacional em relação a\nQuantidade de provedores de nuvem")+
  geom_line() +
  geom_point()+
  xlab("Quantidade de Provedores")+
  ylab("Tempo(Segundos)")+
  #geom_text(aes(label=Média),vjust=-0.5,color="black",position=position_dodge(0.9),size=3.0)+
  theme_economist()

p2

png("tempoProvedoresS.png")
print(p2)
dev.off()
