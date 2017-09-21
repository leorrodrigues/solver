df<- (read.table('temposQntProvedores.txt',sep=';',header=TRUE))
df

p<- ggplot(df, aes(x=Quantidade, y=Tempo)) +
  ggtitle("Tempo computacional em relação a\nQuantidade de provedores de nuvem")+
  geom_line() +
  geom_point()+
  xlab("Quantidade de Provedores")+
  ylab("Tempo(s)")+
  #geom_text(aes(label=Média),vjust=-0.5,color="black",position=position_dodge(0.9),size=3.0)+
  theme_economist()

p

png("tempoProvedoresS.png")
print(p)
dev.off()

p2<- ggplot(df, aes(x=Quantidade, y=MS)) +
  ggtitle("Tempo computacional em relação a\nQuantidade de provedores de nuvem")+
  geom_line() +
  geom_point()+
  xlab("Quantidade de Provedores")+
  ylab("Tempo(Ms)")+
  #geom_text(aes(label=Média),vjust=-0.5,color="black",position=position_dodge(0.9),size=3.0)+
  theme_economist()

p2

png("tempoProvedoresMS.png")
print(p2)
dev.off()
