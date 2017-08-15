# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

#CREATE FILE NUMBERS
numb= Identity.create(number:1)
numb.save
#CREATE THE DEFAULT TREE#
tree_default = Tree.create(name:"default")
tree_custom = Tree.create(name:"custom")
tree_cost = Tree.create(name:"cost")

#CREATE THE CATEGORIES#
category_flat= Category.create(name:"flat")
category_flat.tree=tree_default
category_flat.save

category_seg= Category.create(name:"segurança")
category_seg.tree=tree_default
category_seg.save

category_network= Category.create(name:"rede")
category_network.tree=tree_default
category_network.save

category_qos= Category.create(name:"qos")
category_qos.tree=tree_default
category_qos.save

category_host= Category.create(name:"hospedagem")
category_host.tree=tree_default
category_host.save

category_comunication= Category.create(name:"comunicação")
category_comunication.tree=tree_default
category_comunication.save

category_custom=Category.create(name:"custom")
category_custom.tree=tree_custom
category_custom.save

category_cost=Category.create(name:"cost")
category_cost.tree=tree_cost
category_cost.save

#CREATE THE FLAT TREE#
root_flat = Node.create(name:"Qual provedor de serviço escolher?",weight:0,hight:0)
root_flat.category= category_flat
root_flat.save

infra_node_flat= Node.create(name:"Infraestrutura Virtual",weight:0.5,hight:1)
infra_node_flat.category= category_flat
infra_node_flat.save
infra_child_flat=Child.create(name:"Infraestrutura Virtual")
infra_child_flat.node=root_flat
infra_child_flat.save

servicos_node_flat=Node.create(name:"Serviços",weight:0.5,hight:1)
servicos_node_flat.category= category_flat
servicos_node_flat.save
servicos_child_flat=Child.create(name:"Serviços")
servicos_child_flat.node=root_flat
servicos_child_flat.save

maquina_flat=Node.create(name:"Máquina Virtual",weight:0.25,hight:2)
maquina_flat.category= category_flat
maquina_flat.save
maquina_flat_child=Child.create(name:"Máquina Virtual")
maquina_flat_child.node=infra_node_flat
maquina_flat_child.save

comutador_flat=Node.create(name:"Comutador",weight:0.25,hight:2)
comutador_flat.category= category_flat
comutador_flat.save
comutador_flat_child= Child.create(name:"Comutador")
comutador_flat_child.node=infra_node_flat
comutador_flat_child.save

roteador_flat=Node.create(name:"Roteador",weight:0.25,hight:2)
roteador_flat.category= category_flat
roteador_flat.save
roteador_flat_child=Child.create(name:"Roteador")
roteador_flat_child.node=infra_node_flat
roteador_flat_child.save

sdn_flat=Node.create(name:"Equipamento SDN",weight:0.25,hight:2)
sdn_flat.category= category_flat
sdn_flat.save
sdn_flat_child=Child.create(name:"Equipamento SDN")
sdn_flat_child.node=infra_node_flat
sdn_flat_child.save

seguranca_node_flat=Node.create(name:"Segurança",weight:0.2,hight:2)
seguranca_node_flat.category= category_flat
seguranca_node_flat.save
seguranca_child_flat=Child.create(name:"Segurança")
seguranca_child_flat.node=servicos_node_flat
seguranca_child_flat.save

qos_node_flat=Node.create(name:"QoSServices",weight:0.2,hight:2)
qos_node_flat.category= category_flat
qos_node_flat.save
qos_child_flat=Child.create(name:"QoSServices")
qos_child_flat.node=servicos_node_flat
qos_child_flat.save

dns_flat=Node.create(name:"DNS",weight:0.2,hight:2)
dns_flat.category= category_flat
dns_flat.save
dns_flat_child=Child.create(name:"DNS")
dns_flat_child.node=servicos_node_flat
dns_flat_child.save

bal_flat=Node.create(name:"Balanceador de Carga",weight:0.2,hight:2)
bal_flat.category= category_flat
bal_flat.save
bal_flat_child=Child.create(name:"Balanceador de Carga")
bal_flat_child.node=servicos_node_flat
bal_flat_child.save

rede_node_flat=Node.create(name:"Rede Virtual",weight:0.2,hight:2)
rede_node_flat.category= category_flat
rede_node_flat.save
rede_child_flat=Child.create(name:"Rede Virtual")
rede_child_flat.node=servicos_node_flat
rede_child_flat.save

ids_flat=Node.create(name:"IDS",weight:0.33,hight:3)
ids_flat.category= category_flat
ids_flat.save
ids_flat_child=Child.create(name:"IDS")
ids_flat_child.node=seguranca_node_flat
ids_flat_child.save

nat_flat=Node.create(name:"NAT",weight:0.33,hight:3)
nat_flat.category= category_flat
nat_flat.save
nat_flat_child=Child.create(name:"NAT")
nat_flat_child.node=seguranca_node_flat
nat_flat_child.save

firewall_flat=Node.create(name:"Firewall",weight:0.33,hight:3)
firewall_flat.category= category_flat
firewall_flat.save
firewall_flat_child=Child.create(name:"Firewall")
firewall_flat_child.node=seguranca_node_flat
firewall_flat_child.save

lat_flat=Node.create(name:"Latência",weight:0.5,hight:3)
lat_flat.category= category_flat
lat_flat.save
lat_flat_child=Child.create(name:"Latência")
lat_flat_child.node=qos_node_flat
lat_flat_child.save

larg_flat=Node.create(name:"Largura de Banda",weight:0.5,hight:3)
larg_flat.category= category_flat
larg_flat.save
larg_flat_child=Child.create(name:"Largura de Banda")
larg_flat_child.node=qos_node_flat
larg_flat_child.save

l1_flat=Node.create(name:"L1",weight:0.25,hight:3)
l1_flat.category= category_flat
l1_flat.save
l1_flat_child=Child.create(name:"L1")
l1_flat_child.node=rede_node_flat
l1_flat_child.save

l2_flat=Node.create(name:"L2",weight:0.25,hight:3)
l2_flat.category= category_flat
l2_flat.save
l2_flat_child=Child.create(name:"L2")
l2_flat_child.node=rede_node_flat
l2_flat_child.save

l3_flat=Node.create(name:"L3",weight:0.25,hight:3)
l3_flat.category= category_flat
l3_flat.save
l3_flat_child=Child.create(name:"L3")
l3_flat_child.node=rede_node_flat
l3_flat_child.save

l4_flat=Node.create(name:"L4",weight:0.25,hight:3)
l4_flat.category= category_flat
l4_flat.save
l4_flat_child=Child.create(name:"L4")
l4_flat_child.node=rede_node_flat
l4_flat_child.save

#Create Security Tree
root_seg = Node.create(name:"Qual provedor de serviço escolher?",weight:0,hight:0)
root_seg.category= category_seg
root_seg.save

infra_node_seg= Node.create(name:"Infraestrutura Virtual",weight:0.14,hight:1)
infra_node_seg.category= category_seg
infra_node_seg.save
infra_child_seg=Child.create(name:"Infraestrutura Virtual")
infra_child_seg.node=root_seg
infra_child_seg.save

servicos_node_seg=Node.create(name:"Serviços",weight:0.85,hight:1)
servicos_node_seg.category= category_seg
servicos_node_seg.save
servicos_child_seg=Child.create(name:"Serviços")
servicos_child_seg.node=root_seg
servicos_child_seg.save

maquina_seg=Node.create(name:"Máquina Virtual",weight:0.10,hight:2)
maquina_seg.category= category_seg
maquina_seg.save
maquina_seg_child=Child.create(name:"Máquina Virtual")
maquina_seg_child.node=infra_node_seg
maquina_seg_child.save

comutador_seg=Node.create(name:"Comutador",weight:0.13,hight:2)
comutador_seg.category= category_seg
comutador_seg.save
comutador_seg_child= Child.create(name:"Comutador")
comutador_seg_child.node=infra_node_seg
comutador_seg_child.save

roteador_seg=Node.create(name:"Roteador",weight:0.27,hight:2)
roteador_seg.category= category_seg
roteador_seg.save
roteador_seg_child=Child.create(name:"Roteador")
roteador_seg_child.node=infra_node_seg
roteador_seg_child.save

sdn_seg=Node.create(name:"Equipamento SDN",weight:0.48,hight:2)
sdn_seg.category= category_seg
sdn_seg.save
sdn_seg_child=Child.create(name:"Equipamento SDN")
sdn_seg_child.node=infra_node_seg
sdn_seg_child.save

seguranca_node_seg=Node.create(name:"Segurança",weight:0.54,hight:2)
seguranca_node_seg.category= category_seg
seguranca_node_seg.save
seguranca_child_seg=Child.create(name:"Segurança")
seguranca_child_seg.node=servicos_node_seg
seguranca_child_seg.save

qos_node_seg=Node.create(name:"QoSServices",weight:0.22,hight:2)
qos_node_seg.category= category_seg
qos_node_seg.save
qos_child_seg=Child.create(name:"QoSServices")
qos_child_seg.node=servicos_node_seg
qos_child_seg.save

dns_seg=Node.create(name:"DNS",weight:0.07,hight:2)
dns_seg.category= category_seg
dns_seg.save
dns_seg_child=Child.create(name:"DNS")
dns_seg_child.node=servicos_node_seg
dns_seg_child.save

bal_seg=Node.create(name:"Balanceador de Carga",weight:0.11,hight:2)
bal_seg.category= category_seg
bal_seg.save
bal_seg_child=Child.create(name:"Balanceador de Carga")
bal_seg_child.node=servicos_node_seg
bal_seg_child.save

rede_node_seg=Node.create(name:"Rede Virtual",weight:0.06,hight:2)
rede_node_seg.category= category_seg
rede_node_seg.save
rede_child_seg=Child.create(name:"Rede Virtual")
rede_child_seg.node=servicos_node_seg
rede_child_seg.save

ids_seg=Node.create(name:"IDS",weight:0.26,hight:3)
ids_seg.category= category_seg
ids_seg.save
ids_seg_child=Child.create(name:"IDS")
ids_seg_child.node=seguranca_node_seg
ids_seg_child.save

nat_seg=Node.create(name:"NAT",weight:0.10,hight:3)
nat_seg.category= category_seg
nat_seg.save
nat_seg_child=Child.create(name:"NAT")
nat_seg_child.node=seguranca_node_seg
nat_seg_child.save

firewall_seg=Node.create(name:"Firewall",weight:0.64,hight:3)
firewall_seg.category= category_seg
firewall_seg.save
firewall_seg_child=Child.create(name:"Firewall")
firewall_seg_child.node=seguranca_node_seg
firewall_seg_child.save

lat_seg=Node.create(name:"Latência",weight:0.67,hight:3)
lat_seg.category= category_seg
lat_seg.save
lat_seg_child=Child.create(name:"Latência")
lat_seg_child.node=qos_node_seg
lat_seg_child.save

larg_seg=Node.create(name:"Largura de Banda",weight:0.33,hight:3)
larg_seg.category= category_seg
larg_seg.save
larg_seg_child=Child.create(name:"Largura de Banda")
larg_seg_child.node=qos_node_seg
larg_seg_child.save

l1_seg=Node.create(name:"L1",weight:0.06,hight:3)
l1_seg.category= category_seg
l1_seg.save
l1_seg_child=Child.create(name:"L1")
l1_seg_child.node=rede_node_seg
l1_seg_child.save

l2_seg=Node.create(name:"L2",weight:0.11,hight:3)
l2_seg.category= category_seg
l2_seg.save
l2_seg_child=Child.create(name:"L2")
l2_seg_child.node=rede_node_seg
l2_seg_child.save

l3_seg=Node.create(name:"L3",weight:0.28,hight:3)
l3_seg.category= category_seg
l3_seg.save
l3_seg_child=Child.create(name:"L3")
l3_seg_child.node=rede_node_seg
l3_seg_child.save

l4_seg=Node.create(name:"L4",weight:0.55,hight:3)
l4_seg.category= category_seg
l4_seg.save
l4_seg_child=Child.create(name:"L4")
l4_seg_child.node=rede_node_seg
l4_seg_child.save

#Create Network Tree
root_network = Node.create(name:"Qual provedor de serviço escolher?",weight:0,hight:0)
root_network.category= category_network
root_network.save

infra_node_network= Node.create(name:"Infraestrutura Virtual",weight:0.17,hight:1)
infra_node_network.category= category_network
infra_node_network.save
infra_child_network=Child.create(name:"Infraestrutura Virtual")
infra_child_network.node=root_network
infra_child_network.save

servicos_node_network=Node.create(name:"Serviços",weight:0.83,hight:1)
servicos_node_network.category= category_network
servicos_node_network.save
servicos_child_network=Child.create(name:"Serviços")
servicos_child_network.node=root_network
servicos_child_network.save

maquina_network=Node.create(name:"Máquina Virtual",weight:0.10,hight:2)
maquina_network.category= category_network
maquina_network.save
maquina_network_child=Child.create(name:"Máquina Virtual")
maquina_network_child.node=infra_node_network
maquina_network_child.save

comutador_network=Node.create(name:"Comutador",weight:0.12,hight:2)
comutador_network.category= category_network
comutador_network.save
comutador_network_child= Child.create(name:"Comutador")
comutador_network_child.node=infra_node_network
comutador_network_child.save

roteador_network=Node.create(name:"Roteador",weight:0.26,hight:2)
roteador_network.category= category_network
roteador_network.save
roteador_network_child=Child.create(name:"Roteador")
roteador_network_child.node=infra_node_network
roteador_network_child.save

sdn_network=Node.create(name:"Equipamento SDN",weight:0.52,hight:2)
sdn_network.category= category_network
sdn_network.save
sdn_network_child=Child.create(name:"Equipamento SDN")
sdn_network_child.node=infra_node_network
sdn_network_child.save

seguranca_node_network=Node.create(name:"Segurança",weight:0.20,hight:2)
seguranca_node_network.category= category_network
seguranca_node_network.save
seguranca_child_network=Child.create(name:"Segurança")
seguranca_child_network.node=servicos_node_network
seguranca_child_network.save

qos_node_network=Node.create(name:"QoSServices",weight:0.15,hight:2)
qos_node_network.category= category_network
qos_node_network.save
qos_child_network=Child.create(name:"QoSServices")
qos_child_network.node=servicos_node_network
qos_child_network.save

dns_network=Node.create(name:"DNS",weight:0.07,hight:2)
dns_network.category= category_network
dns_network.save
dns_network_child=Child.create(name:"DNS")
dns_network_child.node=servicos_node_network
dns_network_child.save

bal_network=Node.create(name:"Balanceador de Carga",weight:0.11,hight:2)
bal_network.category= category_network
bal_network.save
bal_network_child=Child.create(name:"Balanceador de Carga")
bal_network_child.node=servicos_node_network
bal_network_child.save

rede_node_network=Node.create(name:"Rede Virtual",weight:0.47,hight:2)
rede_node_network.category= category_network
rede_node_network.save
rede_child_network=Child.create(name:"Rede Virtual")
rede_child_network.node=servicos_node_network
rede_child_network.save

ids_network=Node.create(name:"IDS",weight:0.33,hight:3)
ids_network.category= category_network
ids_network.save
ids_network_child=Child.create(name:"IDS")
ids_network_child.node=seguranca_node_network
ids_network_child.save

nat_network=Node.create(name:"NAT",weight:0.10,hight:3)
nat_network.category= category_network
nat_network.save
nat_network_child=Child.create(name:"NAT")
nat_network_child.node=seguranca_node_network
nat_network_child.save

firewall_network=Node.create(name:"Firewall",weight:0.57,hight:3)
firewall_network.category= category_network
firewall_network.save
firewall_network_child=Child.create(name:"Firewall")
firewall_network_child.node=seguranca_node_network
firewall_network_child.save

lat_network=Node.create(name:"Latência",weight:0.67,hight:3)
lat_network.category= category_network
lat_network.save
lat_network_child=Child.create(name:"Latência")
lat_network_child.node=qos_node_network
lat_network_child.save

larg_network=Node.create(name:"Largura de Banda",weight:0.33,hight:3)
larg_network.category= category_network
larg_network.save
larg_network_child=Child.create(name:"Largura de Banda")
larg_network_child.node=qos_node_network
larg_network_child.save

l1_network=Node.create(name:"L1",weight:0.08,hight:3)
l1_network.category= category_network
l1_network.save
l1_network_child=Child.create(name:"L1")
l1_network_child.node=rede_node_network
l1_network_child.save

l2_network=Node.create(name:"L2",weight:0.12,hight:3)
l2_network.category= category_network
l2_network.save
l2_network_child=Child.create(name:"L2")
l2_network_child.node=rede_node_network
l2_network_child.save

l3_network=Node.create(name:"L3",weight:0.31,hight:3)
l3_network.category= category_network
l3_network.save
l3_network_child=Child.create(name:"L3")
l3_network_child.node=rede_node_network
l3_network_child.save

l4_network=Node.create(name:"L4",weight:0.49,hight:3)
l4_network.category= category_network
l4_network.save
l4_network_child=Child.create(name:"L4")
l4_network_child.node=rede_node_network
l4_network_child.save

#Create QoS Tree
root_qos = Node.create(name:"Qual provedor de serviço escolher?",weight:0,hight:0)
root_qos.category= category_qos
root_qos.save

infra_node_qos= Node.create(name:"Infraestrutura Virtual",weight:0.80,hight:1)
infra_node_qos.category= category_qos
infra_node_qos.save
infra_child_qos=Child.create(name:"Infraestrutura Virtual")
infra_child_qos.node=root_qos
infra_child_qos.save

servicos_node_qos=Node.create(name:"Serviços",weight:0.20,hight:1)
servicos_node_qos.category= category_qos
servicos_node_qos.save
servicos_child_qos=Child.create(name:"Serviços")
servicos_child_qos.node=root_qos
servicos_child_qos.save

maquina_qos=Node.create(name:"Máquina Virtual",weight:0.15,hight:2)
maquina_qos.category= category_qos
maquina_qos.save
maquina_qos_child=Child.create(name:"Máquina Virtual")
maquina_qos_child.node=infra_node_qos
maquina_qos_child.save

comutador_qos=Node.create(name:"Comutador",weight:0.10,hight:2)
comutador_qos.category= category_qos
comutador_qos.save
comutador_qos_child= Child.create(name:"Comutador")
comutador_qos_child.node=infra_node_qos
comutador_qos_child.save

roteador_qos=Node.create(name:"Roteador",weight:0.31,hight:2)
roteador_qos.category= category_qos
roteador_qos.save
roteador_qos_child=Child.create(name:"Roteador")
roteador_qos_child.node=infra_node_qos
roteador_qos_child.save

sdn_qos=Node.create(name:"Equipamento SDN",weight:0.44,hight:2)
sdn_qos.category= category_qos
sdn_qos.save
sdn_qos_child=Child.create(name:"Equipamento SDN")
sdn_qos_child.node=infra_node_qos
sdn_qos_child.save

seguranca_node_qos=Node.create(name:"Segurança",weight:0.24,hight:2)
seguranca_node_qos.category= category_qos
seguranca_node_qos.save
seguranca_child_qos=Child.create(name:"Segurança")
seguranca_child_qos.node=servicos_node_qos
seguranca_child_qos.save

qos_node_qos=Node.create(name:"QoSServices",weight:0.45,hight:2)
qos_node_qos.category= category_qos
qos_node_qos.save
qos_child_qos=Child.create(name:"QoSServices")
qos_child_qos.node=servicos_node_qos
qos_child_qos.save

dns_qos=Node.create(name:"DNS",weight:0.10,hight:2)
dns_qos.category= category_qos
dns_qos.save
dns_qos_child=Child.create(name:"DNS")
dns_qos_child.node=servicos_node_qos
dns_qos_child.save

bal_qos=Node.create(name:"Balanceador de Carga",weight:0.12,hight:2)
bal_qos.category= category_qos
bal_qos.save
bal_qos_child=Child.create(name:"Balanceador de Carga")
bal_qos_child.node=servicos_node_qos
bal_qos_child.save

rede_node_qos=Node.create(name:"Rede Virtual",weight:0.09,hight:2)
rede_node_qos.category= category_qos
rede_node_qos.save
rede_child_qos=Child.create(name:"Rede Virtual")
rede_child_qos.node=servicos_node_qos
rede_child_qos.save

ids_qos=Node.create(name:"IDS",weight:0.31,hight:3)
ids_qos.category= category_qos
ids_qos.save
ids_qos_child=Child.create(name:"IDS")
ids_qos_child.node=seguranca_node_qos
ids_qos_child.save

nat_qos=Node.create(name:"NAT",weight:0.20,hight:3)
nat_qos.category= category_qos
nat_qos.save
nat_qos_child=Child.create(name:"NAT")
nat_qos_child.node=seguranca_node_qos
nat_qos_child.save

firewall_qos=Node.create(name:"Firewall",weight:0.49,hight:3)
firewall_qos.category= category_qos
firewall_qos.save
firewall_qos_child=Child.create(name:"Firewall")
firewall_qos_child.node=seguranca_node_qos
firewall_qos_child.save

lat_qos=Node.create(name:"Latência",weight:0.67,hight:3)
lat_qos.category= category_qos
lat_qos.save
lat_qos_child=Child.create(name:"Latência")
lat_qos_child.node=qos_node_qos
lat_qos_child.save

larg_qos=Node.create(name:"Largura de Banda",weight:0.33,hight:3)
larg_qos.category= category_qos
larg_qos.save
larg_qos_child=Child.create(name:"Largura de Banda")
larg_qos_child.node=qos_node_qos
larg_qos_child.save

l1_qos=Node.create(name:"L1",weight:0.07,hight:3)
l1_qos.category= category_qos
l1_qos.save
l1_qos_child=Child.create(name:"L1")
l1_qos_child.node=rede_node_qos
l1_qos_child.save

l2_qos=Node.create(name:"L2",weight:0.11,hight:3)
l2_qos.category= category_qos
l2_qos.save
l2_qos_child=Child.create(name:"L2")
l2_qos_child.node=rede_node_qos
l2_qos_child.save

l3_qos=Node.create(name:"L3",weight:0.30,hight:3)
l3_qos.category= category_qos
l3_qos.save
l3_qos_child=Child.create(name:"L3")
l3_qos_child.node=rede_node_qos
l3_qos_child.save

l4_qos=Node.create(name:"L4",weight:0.52,hight:3)
l4_qos.category= category_qos
l4_qos.save
l4_qos_child=Child.create(name:"L4")
l4_qos_child.node=rede_node_qos
l4_qos_child.save

#Create Host Tree
root_host = Node.create(name:"Qual provedor de serviço escolher?",weight:0,hight:0)
root_host.category= category_host
root_host.save

infra_node_host= Node.create(name:"Infraestrutura Virtual",weight:0.80,hight:1)
infra_node_host.category= category_host
infra_node_host.save
infra_child_host=Child.create(name:"Infraestrutura Virtual")
infra_child_host.node=root_host
infra_child_host.save

servicos_node_host=Node.create(name:"Serviços",weight:0.20,hight:1)
servicos_node_host.category= category_host
servicos_node_host.save
servicos_child_host=Child.create(name:"Serviços")
servicos_child_host.node=root_host
servicos_child_host.save

maquina_host=Node.create(name:"Máquina Virtual",weight:0.10,hight:2)
maquina_host.category= category_host
maquina_host.save
maquina_host_child=Child.create(name:"Máquina Virtual")
maquina_host_child.node=infra_node_host
maquina_host_child.save

comutador_host=Node.create(name:"Comutador",weight:0.15,hight:2)
comutador_host.category= category_host
comutador_host.save
comutador_host_child= Child.create(name:"Comutador")
comutador_host_child.node=infra_node_host
comutador_host_child.save

roteador_host=Node.create(name:"Roteador",weight:0.31,hight:2)
roteador_host.category= category_host
roteador_host.save
roteador_host_child=Child.create(name:"Roteador")
roteador_host_child.node=infra_node_host
roteador_host_child.save

sdn_host=Node.create(name:"Equipamento SDN",weight:0.43,hight:2)
sdn_host.category= category_host
sdn_host.save
sdn_host_child=Child.create(name:"Equipamento SDN")
sdn_host_child.node=infra_node_host
sdn_host_child.save

seguranca_node_host=Node.create(name:"Segurança",weight:0.44,hight:2)
seguranca_node_host.category= category_host
seguranca_node_host.save
seguranca_child_host=Child.create(name:"Segurança")
seguranca_child_host.node=servicos_node_host
seguranca_child_host.save

qos_node_host=Node.create(name:"QoSServices",weight:0.12,hight:2)
qos_node_host.category= category_host
qos_node_host.save
qos_child_host=Child.create(name:"QoSServices")
qos_child_host.node=servicos_node_host
qos_child_host.save

dns_host=Node.create(name:"DNS",weight:0.09,hight:2)
dns_host.category= category_host
dns_host.save
dns_host_child=Child.create(name:"DNS")
dns_host_child.node=servicos_node_host
dns_host_child.save

bal_host=Node.create(name:"Balanceador de Carga",weight:0.30,hight:2)
bal_host.category= category_host
bal_host.save
bal_host_child=Child.create(name:"Balanceador de Carga")
bal_host_child.node=servicos_node_host
bal_host_child.save

rede_node_host=Node.create(name:"Rede Virtual",weight:0.05,hight:2)
rede_node_host.category= category_host
rede_node_host.save
rede_child_host=Child.create(name:"Rede Virtual")
rede_child_host.node=servicos_node_host
rede_child_host.save

ids_host=Node.create(name:"IDS",weight:0.23,hight:3)
ids_host.category= category_host
ids_host.save
ids_host_child=Child.create(name:"IDS")
ids_host_child.node=seguranca_node_host
ids_host_child.save

nat_host=Node.create(name:"NAT",weight:0.12,hight:3)
nat_host.category= category_host
nat_host.save
nat_host_child=Child.create(name:"NAT")
nat_host_child.node=seguranca_node_host
nat_host_child.save

firewall_host=Node.create(name:"Firewall",weight:0.65,hight:3)
firewall_host.category= category_host
firewall_host.save
firewall_host_child=Child.create(name:"Firewall")
firewall_host_child.node=seguranca_node_host
firewall_host_child.save

lat_host=Node.create(name:"Latência",weight:0.67,hight:3)
lat_host.category= category_host
lat_host.save
lat_host_child=Child.create(name:"Latência")
lat_host_child.node=qos_node_host
lat_host_child.save

larg_host=Node.create(name:"Largura de Banda",weight:0.33,hight:3)
larg_host.category= category_host
larg_host.save
larg_host_child=Child.create(name:"Largura de Banda")
larg_host_child.node=qos_node_host
larg_host_child.save

l1_host=Node.create(name:"L1",weight:0.08,hight:3)
l1_host.category= category_host
l1_host.save
l1_host_child=Child.create(name:"L1")
l1_host_child.node=rede_node_host
l1_host_child.save

l2_host=Node.create(name:"L2",weight:0.18,hight:3)
l2_host.category= category_host
l2_host.save
l2_host_child=Child.create(name:"L2")
l2_host_child.node=rede_node_host
l2_host_child.save

l3_host=Node.create(name:"L3",weight:0.25,hight:3)
l3_host.category= category_host
l3_host.save
l3_host_child=Child.create(name:"L3")
l3_host_child.node=rede_node_host
l3_host_child.save

l4_host=Node.create(name:"L4",weight:0.49,hight:3)
l4_host.category= category_host
l4_host.save
l4_host_child=Child.create(name:"L4")
l4_host_child.node=rede_node_host
l4_host_child.save

#Create Comunication Tree
root_comunication = Node.create(name:"Qual provedor de serviço escolher?",weight:0,hight:0)
root_comunication.category= category_comunication
root_comunication.save

infra_node_comunication= Node.create(name:"Infraestrutura Virtual",weight:0.67,hight:1)
infra_node_comunication.category= category_comunication
infra_node_comunication.save
infra_child_comunication=Child.create(name:"Infraestrutura Virtual")
infra_child_comunication.node=root_comunication
infra_child_comunication.save

servicos_node_comunication=Node.create(name:"Serviços",weight:0.33,hight:1)
servicos_node_comunication.category= category_comunication
servicos_node_comunication.save
servicos_child_comunication=Child.create(name:"Serviços")
servicos_child_comunication.node=root_comunication
servicos_child_comunication.save

maquina_comunication=Node.create(name:"Máquina Virtual",weight:0.11,hight:2)
maquina_comunication.category= category_comunication
maquina_comunication.save
maquina_comunication_child=Child.create(name:"Máquina Virtual")
maquina_comunication_child.node=infra_node_comunication
maquina_comunication_child.save

comutador_comunication=Node.create(name:"Comutador",weight:0.12,hight:2)
comutador_comunication.category= category_comunication
comutador_comunication.save
comutador_comunication_child= Child.create(name:"Comutador")
comutador_comunication_child.node=infra_node_comunication
comutador_comunication_child.save

roteador_comunication=Node.create(name:"Roteador",weight:0.21,hight:2)
roteador_comunication.category= category_comunication
roteador_comunication.save
roteador_comunication_child=Child.create(name:"Roteador")
roteador_comunication_child.node=infra_node_comunication
roteador_comunication_child.save

sdn_comunication=Node.create(name:"Equipamento SDN",weight:0.56,hight:2)
sdn_comunication.category= category_comunication
sdn_comunication.save
sdn_comunication_child=Child.create(name:"Equipamento SDN")
sdn_comunication_child.node=infra_node_comunication
sdn_comunication_child.save

seguranca_node_comunication=Node.create(name:"Segurança",weight:0.09,hight:2)
seguranca_node_comunication.category= category_comunication
seguranca_node_comunication.save
seguranca_child_comunication=Child.create(name:"Segurança")
seguranca_child_comunication.node=servicos_node_comunication
seguranca_child_comunication.save

qos_node_comunication=Node.create(name:"QoSServices",weight:0.37,hight:2)
qos_node_comunication.category= category_comunication
qos_node_comunication.save
qos_child_comunication=Child.create(name:"QoSServices")
qos_child_comunication.node=servicos_node_comunication
qos_child_comunication.save

dns_comunication=Node.create(name:"DNS",weight:0.06,hight:2)
dns_comunication.category= category_comunication
dns_comunication.save
dns_comunication_child=Child.create(name:"DNS")
dns_comunication_child.node=servicos_node_comunication
dns_comunication_child.save

bal_comunication=Node.create(name:"Balanceador de Carga",weight:0.08,hight:2)
bal_comunication.category= category_comunication
bal_comunication.save
bal_comunication_child=Child.create(name:"Balanceador de Carga")
bal_comunication_child.node=servicos_node_comunication
bal_comunication_child.save

rede_node_comunication=Node.create(name:"Rede Virtual",weight:0.40,hight:2)
rede_node_comunication.category= category_comunication
rede_node_comunication.save
rede_child_comunication=Child.create(name:"Rede Virtual")
rede_child_comunication.node=servicos_node_comunication
rede_child_comunication.save

ids_comunication=Node.create(name:"IDS",weight:0.26,hight:3)
ids_comunication.category= category_comunication
ids_comunication.save
ids_comunication_child=Child.create(name:"IDS")
ids_comunication_child.node=seguranca_node_comunication
ids_comunication_child.save

nat_comunication=Node.create(name:"NAT",weight:0.10,hight:3)
nat_comunication.category= category_comunication
nat_comunication.save
nat_comunication_child=Child.create(name:"NAT")
nat_comunication_child.node=seguranca_node_comunication
nat_comunication_child.save

firewall_comunication=Node.create(name:"Firewall",weight:0.64,hight:3)
firewall_comunication.category= category_comunication
firewall_comunication.save
firewall_comunication_child=Child.create(name:"Firewall")
firewall_comunication_child.node=seguranca_node_comunication
firewall_comunication_child.save

lat_comunication=Node.create(name:"Latência",weight:0.67,hight:3)
lat_comunication.category= category_comunication
lat_comunication.save
lat_comunication_child=Child.create(name:"Latência")
lat_comunication_child.node=qos_node_comunication
lat_comunication_child.save

larg_comunication=Node.create(name:"Largura de Banda",weight:0.33,hight:3)
larg_comunication.category= category_comunication
larg_comunication.save
larg_comunication_child=Child.create(name:"Largura de Banda")
larg_comunication_child.node=qos_node_comunication
larg_comunication_child.save

l1_comunication=Node.create(name:"L1",weight:0.09,hight:3)
l1_comunication.category= category_comunication
l1_comunication.save
l1_comunication_child=Child.create(name:"L1")
l1_comunication_child.node=rede_node_comunication
l1_comunication_child.save

l2_comunication=Node.create(name:"L2",weight:0.18,hight:3)
l2_comunication.category= category_comunication
l2_comunication.save
l2_comunication_child=Child.create(name:"L2")
l2_comunication_child.node=rede_node_comunication
l2_comunication_child.save

l3_comunication=Node.create(name:"L3",weight:0.29,hight:3)
l3_comunication.category= category_comunication
l3_comunication.save
l3_comunication_child=Child.create(name:"L3")
l3_comunication_child.node=rede_node_comunication
l3_comunication_child.save

l4_comunication=Node.create(name:"L4",weight:0.44,hight:3)
l4_comunication.category= category_comunication
l4_comunication.save
l4_comunication_child=Child.create(name:"L4")
l4_comunication_child.node=rede_node_comunication
l4_comunication_child.save

#Create Custom Tree
root_custom = Node.create(name:"Qual provedor de serviço escolher?",weight:0,hight:0)
root_custom.category= category_custom
root_custom.save

infra_node_custom= Node.create(name:"Infraestrutura Virtual",weight:0.5,hight:1)
infra_node_custom.category= category_custom
infra_node_custom.save
infra_child_custom=Child.create(name:"Infraestrutura Virtual")
infra_child_custom.node=root_custom
infra_child_custom.save

servicos_node_custom=Node.create(name:"Serviços",weight:0.5,hight:1)
servicos_node_custom.category= category_custom
servicos_node_custom.save
servicos_child_custom=Child.create(name:"Serviços")
servicos_child_custom.node=root_custom
servicos_child_custom.save

maquina_custom=Node.create(name:"Máquina Virtual",weight:0.25,hight:2)
maquina_custom.category= category_custom
maquina_custom.save
maquina_custom_child=Child.create(name:"Máquina Virtual")
maquina_custom_child.node=infra_node_custom
maquina_custom_child.save

comutador_custom=Node.create(name:"Comutador",weight:0.25,hight:2)
comutador_custom.category= category_custom
comutador_custom.save
comutador_custom_child= Child.create(name:"Comutador")
comutador_custom_child.node=infra_node_custom
comutador_custom_child.save

roteador_custom=Node.create(name:"Roteador",weight:0.25,hight:2)
roteador_custom.category= category_custom
roteador_custom.save
roteador_custom_child=Child.create(name:"Roteador")
roteador_custom_child.node=infra_node_custom
roteador_custom_child.save

sdn_custom=Node.create(name:"Equipamento SDN",weight:0.25,hight:2)
sdn_custom.category= category_custom
sdn_custom.save
sdn_custom_child=Child.create(name:"Equipamento SDN")
sdn_custom_child.node=infra_node_custom
sdn_custom_child.save

seguranca_node_custom=Node.create(name:"Segurança",weight:0.2,hight:2)
seguranca_node_custom.category= category_custom
seguranca_node_custom.save
seguranca_child_custom=Child.create(name:"Segurança")
seguranca_child_custom.node=servicos_node_custom
seguranca_child_custom.save

qos_node_custom=Node.create(name:"QoSServices",weight:0.2,hight:2)
qos_node_custom.category= category_custom
qos_node_custom.save
qos_child_custom=Child.create(name:"QoSServices")
qos_child_custom.node=servicos_node_custom
qos_child_custom.save

dns_custom=Node.create(name:"DNS",weight:0.2,hight:2)
dns_custom.category= category_custom
dns_custom.save
dns_custom_child=Child.create(name:"DNS")
dns_custom_child.node=servicos_node_custom
dns_custom_child.save

bal_custom=Node.create(name:"Balanceador de Carga",weight:0.2,hight:2)
bal_custom.category= category_custom
bal_custom.save
bal_custom_child=Child.create(name:"Balanceador de Carga")
bal_custom_child.node=servicos_node_custom
bal_custom_child.save

rede_node_custom=Node.create(name:"Rede Virtual",weight:0.2,hight:2)
rede_node_custom.category= category_custom
rede_node_custom.save
rede_child_custom=Child.create(name:"Rede Virtual")
rede_child_custom.node=servicos_node_custom
rede_child_custom.save

ids_custom=Node.create(name:"IDS",weight:0.33,hight:3)
ids_custom.category= category_custom
ids_custom.save
ids_custom_child=Child.create(name:"IDS")
ids_custom_child.node=seguranca_node_custom
ids_custom_child.save

nat_custom=Node.create(name:"NAT",weight:0.33,hight:3)
nat_custom.category= category_custom
nat_custom.save
nat_custom_child=Child.create(name:"NAT")
nat_custom_child.node=seguranca_node_custom
nat_custom_child.save

firewall_custom=Node.create(name:"Firewall",weight:0.33,hight:3)
firewall_custom.category= category_custom
firewall_custom.save
firewall_custom_child=Child.create(name:"Firewall")
firewall_custom_child.node=seguranca_node_custom
firewall_custom_child.save

lat_custom=Node.create(name:"Latência",weight:0.5,hight:3)
lat_custom.category= category_custom
lat_custom.save
lat_custom_child=Child.create(name:"Latência")
lat_custom_child.node=qos_node_custom
lat_custom_child.save

larg_custom=Node.create(name:"Largura de Banda",weight:0.5,hight:3)
larg_custom.category= category_custom
larg_custom.save
larg_custom_child=Child.create(name:"Largura de Banda")
larg_custom_child.node=qos_node_custom
larg_custom_child.save

l1_custom=Node.create(name:"L1",weight:0.25,hight:3)
l1_custom.category= category_custom
l1_custom.save
l1_custom_child=Child.create(name:"L1")
l1_custom_child.node=rede_node_custom
l1_custom_child.save

l2_custom=Node.create(name:"L2",weight:0.25,hight:3)
l2_custom.category= category_custom
l2_custom.save
l2_custom_child=Child.create(name:"L2")
l2_custom_child.node=rede_node_custom
l2_custom_child.save

l3_custom=Node.create(name:"L3",weight:0.25,hight:3)
l3_custom.category= category_custom
l3_custom.save
l3_custom_child=Child.create(name:"L3")
l3_custom_child.node=rede_node_custom
l3_custom_child.save

l4_custom=Node.create(name:"L4",weight:0.25,hight:3)
l4_custom.category= category_custom
l4_custom.save
l4_custom_child=Child.create(name:"L4")
l4_custom_child.node=rede_node_custom
l4_custom_child.save


#CREATE THE COST TREE#
root_cost = Node.create(name:"Qual é o provedor de serviço com menor custo?",weight:0,hight:0)
root_cost.category= category_cost
root_cost.save

infra_node_cost= Node.create(name:"Infraestrutura Virtual",weight:0.5,hight:1)
infra_node_cost.category= category_cost
infra_node_cost.save
infra_child_cost=Child.create(name:"Infraestrutura Virtual")
infra_child_cost.node=root_cost
infra_child_cost.save

servicos_node_cost=Node.create(name:"Serviços",weight:0.5,hight:1)
servicos_node_cost.category= category_cost
servicos_node_cost.save
servicos_child_cost=Child.create(name:"Serviços")
servicos_child_cost.node=root_cost
servicos_child_cost.save

maquina_cost=Node.create(name:"Máquina Virtual",weight:0.25,hight:2)
maquina_cost.category= category_cost
maquina_cost.save
maquina_cost_child=Child.create(name:"Máquina Virtual")
maquina_cost_child.node=infra_node_cost
maquina_cost_child.save

comutador_cost=Node.create(name:"Comutador",weight:0.25,hight:2)
comutador_cost.category= category_cost
comutador_cost.save
comutador_cost_child= Child.create(name:"Comutador")
comutador_cost_child.node=infra_node_cost
comutador_cost_child.save

roteador_cost=Node.create(name:"Roteador",weight:0.25,hight:2)
roteador_cost.category= category_cost
roteador_cost.save
roteador_cost_child=Child.create(name:"Roteador")
roteador_cost_child.node=infra_node_cost
roteador_cost_child.save

sdn_cost=Node.create(name:"Equipamento SDN",weight:0.25,hight:2)
sdn_cost.category= category_cost
sdn_cost.save
sdn_cost_child=Child.create(name:"Equipamento SDN")
sdn_cost_child.node=infra_node_cost
sdn_cost_child.save

seguranca_node_cost=Node.create(name:"Segurança",weight:0.2,hight:2)
seguranca_node_cost.category= category_cost
seguranca_node_cost.save
seguranca_child_cost=Child.create(name:"Segurança")
seguranca_child_cost.node=servicos_node_cost
seguranca_child_cost.save

qos_node_cost=Node.create(name:"QoSServices",weight:0.2,hight:2)
qos_node_cost.category= category_cost
qos_node_cost.save
qos_child_cost=Child.create(name:"QoSServices")
qos_child_cost.node=servicos_node_cost
qos_child_cost.save

dns_cost=Node.create(name:"DNS",weight:0.2,hight:2)
dns_cost.category= category_cost
dns_cost.save
dns_cost_child=Child.create(name:"DNS")
dns_cost_child.node=servicos_node_cost
dns_cost_child.save

bal_cost=Node.create(name:"Balanceador de Carga",weight:0.2,hight:2)
bal_cost.category= category_cost
bal_cost.save
bal_cost_child=Child.create(name:"Balanceador de Carga")
bal_cost_child.node=servicos_node_cost
bal_cost_child.save

rede_node_cost=Node.create(name:"Rede Virtual",weight:0.2,hight:2)
rede_node_cost.category= category_cost
rede_node_cost.save
rede_child_cost=Child.create(name:"Rede Virtual")
rede_child_cost.node=servicos_node_cost
rede_child_cost.save

#Create the alternatives
rack_flat=Alternative.create(name:"Rackspace",weight:0.25)
rack_flat.category= category_flat
rack_flat.save
rack_seg=Alternative.create(name:"Rackspace",weight:0.25)
rack_seg.category= category_seg
rack_seg.save
rack_qos=Alternative.create(name:"Rackspace",weight:0.25)
rack_qos.category= category_qos
rack_qos.save
rack_rede=Alternative.create(name:"Rackspace",weight:0.25)
rack_rede.category= category_network
rack_rede.save
rack_hospedagem=Alternative.create(name:"Rackspace",weight:0.25)
rack_hospedagem.category= category_host
rack_hospedagem.save
rack_comunicacao=Alternative.create(name:"Rackspace",weight:0.25)
rack_comunicacao.category= category_comunication
rack_comunicacao.save

azure_flat=Alternative.create(name:"Microsoft Azure",weight:0.25)
azure_flat.category= category_flat
azure_flat.save
azure_seg=Alternative.create(name:"Microsoft Azure",weight:0.25)
azure_seg.category= category_seg
azure_seg.save
azure_qos=Alternative.create(name:"Microsoft Azure",weight:0.25)
azure_qos.category= category_qos
azure_qos.save
azure_rede=Alternative.create(name:"Microsoft Azure",weight:0.25)
azure_rede.category= category_network
azure_rede.save
azure_hospedagem=Alternative.create(name:"Microsoft Azure",weight:0.25)
azure_hospedagem.category= category_host
azure_hospedagem.save
azure_comunicacao=Alternative.create(name:"Microsoft Azure",weight:0.25)
azure_comunicacao.category= category_comunication
azure_comunicacao.save

aws_flat=Alternative.create(name:"Amazon AWS",weight:0.25)
aws_flat.category= category_flat
aws_flat.save
aws_seg=Alternative.create(name:"Amazon AWS",weight:0.25)
aws_seg.category= category_seg
aws_seg.save
aws_qos=Alternative.create(name:"Amazon AWS",weight:0.25)
aws_qos.category= category_qos
aws_qos.save
aws_rede=Alternative.create(name:"Amazon AWS",weight:0.25)
aws_rede.category= category_network
aws_rede.save
aws_hospedagem=Alternative.create(name:"Amazon AWS",weight:0.25)
aws_hospedagem.category= category_host
aws_hospedagem.save
aws_comunicacao=Alternative.create(name:"Amazon AWS",weight:0.25)
aws_comunicacao.category= category_comunication
aws_comunicacao.save

google_flat=Alternative.create(name:"Google Cloud",weight:0.25)
google_flat.category= category_flat
google_flat.save
google_seg=Alternative.create(name:"Google Cloud",weight:0.25)
google_seg.category= category_seg
google_seg.save
google_qos=Alternative.create(name:"Google Cloud",weight:0.25)
google_qos.category= category_qos
google_qos.save
google_rede=Alternative.create(name:"Google Cloud",weight:0.25)
google_rede.category= category_network
google_rede.save
google_hospedagem=Alternative.create(name:"Google Cloud",weight:0.25)
google_hospedagem.category= category_host
google_hospedagem.save
google_comunicacao=Alternative.create(name:"Google Cloud",weight:0.25)
google_comunicacao.category= category_comunication
google_comunicacao.save
