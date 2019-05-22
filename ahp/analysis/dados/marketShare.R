library(ggplot2) # for creating ggplot
library(ggthemes)

df<- (read.table('dadosMarket.txt',header=TRUE,sep=';'))
df

p<- ggplot(data=df,aes(x=Referência,y=Valor,fill = Provedor)) +
    xlab('Reference') + 
    ylab('Selection Frequency(%)') +
    theme_classic()+
    geom_bar(stat="identity",color="black",position=position_dodge())+
    scale_fill_grey(start = .3, end = 1)+
    theme(
        legend.position="top",
        axis.text.x = element_text(
            angle = 0, 
            hjust = .5,
            size=15,
        ),
        axis.line = element_line(colour = "black"),
        axis.text.y = element_text(size=15),
        axis.title.x = element_text(size=15),
        axis.title.y = element_text(size=16),
        legend.text = element_text(size=14),
        legend.title = element_text(size=15)
    )+
    scale_x_discrete(labels=c(
        "(COLES,2017)",
        "(GROUP,2017)",
        "(HALL,2017)",
        "(FAHP)",
        "(VIMAM)"
        )
    )+
    ylim(0,100)+
    labs(fill='Provedor')

p

pdf("marketShare.pdf",width=10.3, height=4.7)
print(p)
dev.off()