flat=open("../weights/flat.hrc","w")
cost=open("../weights/cost.hrc","w")

n=int(input("Digite o numero de provedores: "))

#Escrevendo arquivo FLAT
for i in range(4):
    flat.write("1;")

flat.write("\n")

for i in range(16):
    flat.write("1;")
flat.write("\n")

for i in range(25):
    flat.write("1;")
flat.write("\n")

for j in range(4):
    for i in range(n*n):
        flat.write("1;")
    flat.write("\n")

for i in range(9):
    flat.write("1;")
flat.write("\n")

for i in range(4):
    flat.write("1;")
flat.write("\n")

for j in range(2):
    for i in range(n*n):
        flat.write("1;")
    flat.write("\n")

for i in range(16):
    flat.write("1;")
flat.write("\n")

for j in range(9):
    for i in range(n*n):
        flat.write("1;")
    flat.write("\n")

#Escrevendo o arquivo COST

for i in range(4):
    cost.write("1;")
cost.write("\n")

for i in range(16):
    cost.write("1;")
cost.write("\n")

for i in range(25):
    cost.write("1;")
cost.write("\n")

for j in range(9):
    for i in range(n*n):
        cost.write("1;")
    cost.write("\n")


t1=open("../tree/tree.hrc","w")
t2=open("../tree/treeCost.hrc","w")

t1.write("""Qual provedor de serviço escolher?: Infraestrutura Virtual; Serviços;
Infraestrutura Virtual: Máquina Virtual; Comutador; Roteador; Equipamento SDN;
Serviços: Segurança; QoSServices; DNS; Balanceador de carga; Rede Virtual;
Segurança: IDS; NAT; Firewall;
QoSServices: Latência; Largura de banda;
DNS: Alternatives;
Balanceador de carga: Alternatives;
Rede Virtual: L1; L2; L3; L4;
Máquina Virtual: Alternatives;
Comutador: Alternatives;
Roteador: Alternatives;
Equipamento SDN: Alternatives;
IDS: Alternatives;
NAT: Alternatives;
Firewall: Alternatives;
Latência: Alternatives;
Largura de banda: Alternatives;
L1: Alternatives;
L2: Alternatives;
L3: Alternatives;
L4: Alternatives;
Alternatives: """)

t2.write("""Qual é o provedor de serviço com menor custo?: Infraestrutura Virtual; Serviços;
Infraestrutura Virtual: Máquina Virtual; Comutador; Roteador; Equipamento SDN;
Serviços: Segurança; QoSServices; DNS; Balanceador de carga; Rede Virtual;
Segurança: Alternatives;
QoSServices: Alternatives;
DNS: Alternatives;
Balanceador de carga: Alternatives;
Rede Virtual: Alternatives;
Máquina Virtual: Alternatives;
Comutador: Alternatives;
Roteador: Alternatives;
Equipamento SDN: Alternatives;
Alternatives: """)

for i in range(n):
    t1.write("Alt%i;"%i)
    t2.write("Alt%i;"%i)

flat.close()
cost.close()
t1.close()
t2.close()
