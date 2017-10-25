file=open("results.hrc","r+")

count=0
aws=0
azure=0
google=0
rack=0
aws_min=1000000000000000
aws_max=0
azure_min=1000000000000000
azure_max=0
rack_min=1000000000000000
rack_max=0
google_min=1000000000000000
google_max=0

while True:
    line=file.readline()
    line=line.rstrip()
    if not line:
        break
    line=line.split(" - ")
    line[4]=line[4].split(';')
    for i in range(4):
        line[4][i]=float(line[4][i])
    rack+=line[4][0]
    if line[4][0]<rack_min :
        rack_min=line[4][0]
    if line[4][0]>rack_max:
        rack_max=line[4][0]
    azure+=line[4][1]
    if line[4][1]<azure_min :
        azure_min=line[4][1]
    if line[4][1]>azure_max:
        azure_max=line[4][1]
    aws+=line[4][2]
    if line[4][2]<aws_min :
        aws_min=line[4][2]
    if line[4][2]>aws_max:
        aws_max=line[4][2]
    google+=line[4][3]
    if line[4][3]<google_min :
        google_min=line[4][3]
    if line[4][3]>google_max:
        google_max=line[4][3]

rack_media=rack/1000
azure_media=azure/1000
aws_media=aws/1000
google_media=google/1000

aws_desvio=0
google_desvio=0
azure_desvio=0
rack_desvio=0

file.close
file=open("results.hrc","r+")


while True:
    line=file.readline()
    line=line.rstrip()
    if not line:
        break
    line=line.split(" - ")
    line[4]=line[4].split(';')
    for i in range(4):
        line[4][i]=float(line[4][i])
    rack_desvio+=(line[4][0]-rack_media)**2
    azure_desvio+=(line[4][1]-azure_media)**2
    aws_desvio+=(line[4][2]-aws_media)**2
    google_desvio+=(line[4][3]-google_media)**2

import math

rack_desvio=math.sqrt(rack_desvio/1000)
azure_desvio=math.sqrt(azure_desvio/1000)
aws_desvio=math.sqrt(aws_desvio/1000)
google_desvio=math.sqrt(google_desvio/1000)

vez="Pesquisa"

print(vez+";Rackspace;"+str(rack_media)+";"+str(rack_min)+";"+str(rack_max)+";"+str(rack_desvio))
print(vez+";Microsoft Azure;"+str(azure_media)+";"+str(azure_min)+";"+str(azure_max)+";"+str(azure_desvio))
print(vez+";Amazon AWS;"+str(aws_media)+";"+str(aws_min)+";"+str(aws_max)+";"+str(aws_desvio))
print(vez+";Google Cloud;"+str(google_media)+";"+str(google_min)+";"+str(google_max)+";"+str(google_desvio))
