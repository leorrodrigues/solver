file=open("results_vimam.hrc","r+")

file2=open("PORRA.txt","w")

opt=int(input())

if opt==1:
    cenario="FLAT"
elif opt==2:
    cenario="Segurança"
elif opt==3:
    cenario="Rede"
elif opt==4:
    cenario="Qualidade de Serviço Reservada"
elif opt==5:
    cenario="Hospedagem de Serviços"
elif opt==6:
    cenario="Comunicação de Dados"
elif opt==7:
    cenario="Pesquisa"
elif opt==8:
    cenario="Custo"
elif opt==9:
    cenario="VIMAM"
while True:
    line=file.readline()
    line=line.rstrip()
    if not line:
        break
    line=line.split(" - ")
    line[4]=line[4].split(';')
    for i in range(4):
        line[4][i]=float(line[4][i])

    file2.write(cenario+";Rackspace;"+str(line[4][0])+"\n")
    file2.write(cenario+";Microsoft Azure;"+str(line[4][1])+"\n")
    file2.write(cenario+";Amazon AWS;"+str(line[4][2])+"\n")
    file2.write(cenario+";Google Cloud;"+str(line[4][3])+"\n")

file2.close()
file.close()
