library(ggplot2) # for creating ggplot
library(ggthemes)

df<- (read.table('dadosMarket.txt',header=TRUE,sep=';'))
df

p<- ggplot(data=df, 
       aes(x='',
           y=Valor,
           fill = Provedor)) +
  geom_bar(width = 1,stat="identity") + 
  coord_polar(theta='y') +
  xlab('') + 
  #theme_economist(base_size=7)+
  ylab('') +
  scale_fill_manual(values=c("#ff9900", "#2F4F4F", "#006600","#0000ff","#ff1a1a"))+
  labs(fill='Provedor')+
  #geom_text(aes(y=Valor+0.5,label=Valor),color="black",size=3.0)+
  theme(axis.text.x = element_text(angle=0, hjust = 1),strip.text.y=element_text(angle=0))+
  facet_grid(facets=  Referência ~ .)

p

pdf("marketShare.pdf")
print(p)
dev.off()