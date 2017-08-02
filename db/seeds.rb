# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tree_default = Tree.create(name:"default")
root_flat = Node.create(name:"Qual provedor de serviço escolher?",weight:0,hight:0)
category_flat= Category.create(name:"flat")
category_flat.tree=tree_default
category_flat.node=root_flat
category_flat.save

infra_node_flat= Node.create(name:"Infraestrutura Virtual",weight:0.5,hight:1)
infra_child_flat=Child.create(name:"Infraestrutura Virtual")
infra_child_flat.node=root_flat
infra_child_flat.save

servicos_node_flat=Node.create(name:"Serviços",weight:0.5,hight:1)
servicos_child_flat=Child.create(name:"Serviços")
servicos_child_flat.node=root_flat
servicos_child_flat.save

Node.create(name:"Máquina Virtual",weight:0.25,hight:2)
maquina_flat=Child.create(name:"Máquina Virtual")
maquina_flat.node=infra_node_flat
maquina_flat.save

Node.create(name:"Comutador",weight:0.25,hight:2)
comutador_flat= Child.create(name:"Comutador")
comutador_flat.node=infra_node_flat
comutador_flat.save

Node.create(name:"Roteador",weight:0.25,hight:2)
roteador_flat=Child.create(name:"Roteador")
roteador_flat.node=infra_node_flat
roteador_flat.save

Node.create(name:"Equipamento SDN",weight:0.25,hight:2)
sdn_flat=Child.create(name:"Equipamento SDN")
sdn_flat.node=infra_node_flat
sdn_flat.save

seguranca_node_flat=Node.create(name:"Segurança",weight:0.2,hight:2)
seguranca_child_flat=Child.create(name:"Segurança")
seguranca_child_flat.node=servicos_node_flat
seguranca_child_flat.save

qos_node_flat=Node.create(name:"QoSServices",weight:0.2,hight:2)
qos_child_flat=Child.create(name:"QoSServices")
qos_child_flat.node=servicos_node_flat
qos_child_flat.save

Node.create(name:"DNS",weight:0.2,hight:2)
dns_flat=Child.create(name:"DNS")
dns_flat.node=servicos_node_flat
dns_flat.save

Node.create(name:"Balanceador de Carga",weight:0.2,hight:2)
bal_flat=Child.create(name:"Balanceador de Carga")
bal_flat.node=servicos_node_flat
bal_flat.save

rede_node_flat=Node.create(name:"Rede Virtual",weight:0.2,hight:2)
rede_child_flat=Child.create(name:"Rede Virtual")
rede_child_flat.node=servicos_node_flat
rede_child_flat.save

Node.create(name:"IDS",weight:0.33,hight:3)
ids_flat=Child.create(name:"IDS")
ids_flat.node=seguranca_node_flat
ids_flat.save

Node.create(name:"NAT",weight:0.33,hight:3)
nat_flat=Child.create(name:"NAT")
nat_flat.node=seguranca_node_flat
nat_flat.save

Node.create(name:"Firewall",weight:0.33,hight:3)
firewall_flat=Child.create(name:"Firewall")
firewall_flat.node=seguranca_node_flat
firewall_flat.save

Node.create(name:"Latência",weight:0.5,hight:3)
lat_flat=Child.create(name:"Latência")
lat_flat.node=qos_node_flat
lat_flat.save

Node.create(name:"Largura de Banda",weight:0.5,hight:3)
larg_flat=Child.create(name:"Largura de Banda")
larg_flat.node=qos_node_flat
larg_flat.save

Node.create(name:"L1",weight:0.25,hight:3)
l1_flat=Child.create(name:"L1")
l1_flat.node=rede_node_flat
l1_flat.save

Node.create(name:"L2",weight:0.25,hight:3)
l2_flat=Child.create(name:"L2")
l2_flat.node=rede_node_flat
l2_flat.save

Node.create(name:"L3",weight:0.25,hight:3)
l3_flat=Child.create(name:"L3")
l3_flat.node=rede_node_flat
l3_flat.save

Node.create(name:"L4",weight:0.25,hight:3)
l4_flat=Child.create(name:"L4")
l4_flat.node=rede_node_flat
l4_flat.save

Alternative.create(name:"Rackspace",weight:0.25)
Alternative.create(name:"Microsoft Azure",weight:0.25)
Alternative.create(name:"Amazon AWS",weight:0.25)
Alternative.create(name:"Google Cloud",weight:0.25)
