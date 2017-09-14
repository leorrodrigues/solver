a<- (read.table('temposQntProvedores.txt',sep=';'))
l1<-as.numeric(a[[1]])
l2<-as.numeric(a[[2]])
png('plot-temposQ.png')
plot(l1,l2,main="Tempo computacional em relação a quantidade\nde provedores de nuvem",xlab = "Quantidade de Provedores",ylab="Intervalo (ms)",type='l')
dev.off()

#para mudar o tipo de grafico so fazer type='l' 
#          ‘type’ what type of plot should be drawn.  Possible types are#
#
#                • ‘"p"’ for *p*oints,
#
#                • ‘"l"’ for *l*ines,
#
#                • ‘"b"’ for *b*oth,
#
#                • ‘"c"’ for the lines part alone of ‘"b"’,
#
#                • ‘"o"’ for both ‘*o*verplotted’,
#
#                • ‘"h"’ for ‘*h*istogram’ like (or ‘high-density’)
#                  vertical lines,
#
#                • ‘"s"’ for stair *s*teps,
#
#                • ‘"S"’ for other *s*teps, see ‘Details’ below,
#
#                • ‘"n"’ for no plotting.
##
##
