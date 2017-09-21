file=open("results.hrc","r+")

file2=open("PORRA.txt","w")

cenario="Custo"

while True:
    line=file.readline()
    line=line.rstrip()
    if not line:
        break
    line=line.split(" - ")
    line[3]=line[3].split(';')
    for i in range(4):
        line[3][i]=float(line[3][i])

    file2.write(cenario+";Rackspace;"+str(line[3][0])+"\n")
    file2.write(cenario+";Microsoft Azure;"+str(line[3][1])+"\n")
    file2.write(cenario+";Amazon AWS;"+str(line[3][2])+"\n")
    file2.write(cenario+";Google Cloud;"+str(line[3][3])+"\n")

file2.close()
file.close()
