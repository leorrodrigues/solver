library(ggplot2) # for creating ggplot
library(ggthemes)
library(grid)

df<- (read.table('dadosProvedor.txt',sep=';',header=TRUE))

df2<- (read.table('dadosHisto.txt',sep=";",header=TRUE))

df3<- (read.table('dadosProvedor2.txt',sep=";",header=TRUE))

m2<-merge(df2,df3,by.x=c("Cenario","Provider"),by.y=c("Cenario","Provider"))

p2<- ggplot(m2, aes(x=Cenario, y=Selecao.y, fill=Provider)) +
  #ggtitle("Desvio padrão das alternativas em relação\nAo cenário")+
  #geom_bar(stat="identity", color="black",position=position_dodge()) +
  geom_boxplot(color="black",outlier.shape=NA)+
  xlab("")+
  theme_classic()+
  ylab("Rank Value")+
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
        "Market\nResearch",
        "QoS",
        "Network\nElasticity",
        "Security",
        "FAHP"
    )
    )+
  coord_cartesian(ylim = c(0.21, 0.30)) 

p2

pdf("boxplot_fahp.pdf",width=8.3, height=5.7)
print(p2)
dev.off()



