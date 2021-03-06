df<- (read.table('dadosHisto.txt',header=TRUE,sep=';'))
df

library(ggplot2)
library("ggthemes")

h<-ggplot(data=df,aes(x=Cenario,y=Selecao,fill=Provider))+
    xlab("")+
    ylab("Selection Frequency(%)")+
    theme_classic()+
    ylim(0, 100)+
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
        "Network\nIntensive",
        "Costs",
        "Flat",
        "Web\nHosting",
        "Market\nResearch",
        "QoS",
        "Network\nElasticity",
        "Security",
        "FAHP"
        )
    )
h

pdf("histograma.pdf",width=8.3, height=5.7)
print(h)
dev.off()

t.test(df$Selecao)