import os

file=open("ahp/analysis/requisitions.txt","r+")

while True:
    line=file.readline()
    line=line.rstrip()
    if not line:
        break

    arguments=""
    line=line.split(";")
    arguments+=line[0]

    line[1]=line[1].split(",")
    for i in line[1]:
            arguments+=" "+str(i)

    line[2]=line[2].split(",")
    for i in line[2]:
        arguments+=" "+str(i)

    os.system("./ahp/solver "+arguments)
