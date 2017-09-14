import random

arquivo=open("requisitions.txt","w")

n=int(input("Digite o numero de requisicoes a ser criado: "))
x=int(input("Digite o cenario que deseja: "))
random.seed()
for i in range (n):
    arquivo.write(str(i)+";")
    arquivo.write(str(random.randint(1,20))+","+str(random.randint(1,10))+","+str(random.randint(1,128))+","+str(random.randint(1,102400))+";")

    #arquivo.write("8, 1, 2, 3, 4, 5, 6")
    arquivo.write("8,%i"%x)
    '''
    arquivo.write("8,")
    chose=[]
    tam=random.randint(1,6)
    for i in range(0,tam):
        while True:
            x=random.randint(1,6)
            if not x in chose:
                if i!=tam-1:
                    arquivo.write(str(x)+",")
                else:
                    arquivo.write(str(x))
                chose.append(x)
                break
    '''
    arquivo.write("\n")

arquivo.close()
