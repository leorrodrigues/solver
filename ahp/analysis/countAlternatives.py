file=open("results_vimam.hrc","r+")

pg={}
custo={}
form={}

amazon_pg={'1':0,'2':0,'3':0,'4':0}
azure_pg={'1':0,'2':0,'3':0,'4':0}
rack_pg={'1':0,'2':0,'3':0,'4':0}
google_pg={'1':0,'2':0,'3':0,'4':0}

amazon_custo={'1':0,'2':0,'3':0,'4':0}
azure_custo={'1':0,'2':0,'3':0,'4':0}
rack_custo={'1':0,'2':0,'3':0,'4':0}
google_custo={'1':0,'2':0,'3':0,'4':0}

amazon_form={'1':0,'2':0,'3':0,'4':0}
azure_form={'1':0,'2':0,'3':0,'4':0}
rack_form={'1':0,'2':0,'3':0,'4':0}
google_form={'1':0,'2':0,'3':0,'4':0}

while True:
    count={}
    req=[]
    line=file.readline()
    line=line.rstrip()
    if not line:
        break

    line=line.split(" - ")

    pg_aux=[]
    line[2]=line[2].split(';')
    for i in line[2]:
        if i !="":
            pg_aux.append(float(i))

    x=1
    while True:
        n_max= max(pg_aux)
        if n_max == -1:
            break
        n_pos=pg_aux.index(n_max)
        pg_aux[n_pos]=-1
        if n_pos==0:
            rack_pg[str(x)]+=1
        elif n_pos==1:
            azure_pg[str(x)]+=1
        elif n_pos==2:
            amazon_pg[str(x)]+=1
        elif n_pos==3:
            google_pg[str(x)]+=1
        x+=1

    custo_aux=[]
    line[3]=line[3].split(';')
    for i in line[3]:
        if i !="":
            custo_aux.append(float(i))

    x=1
    while True:
        n_max= max(custo_aux)
        if n_max == -1:
            break
        n_pos=custo_aux.index(n_max)
        custo_aux[n_pos]=-1
        if n_pos==0:
            rack_custo[str(x)]+=1
        elif n_pos==1:
            azure_custo[str(x)]+=1
        elif n_pos==2:
            amazon_custo[str(x)]+=1
        elif n_pos==3:
            google_custo[str(x)]+=1
        x+=1

    form_aux=[]
    line[4]=line[4].split(';')
    for i in line[4]:
        if i !="":
            form_aux.append(float(i))

    x=1
    while True:
        n_max= max(form_aux)
        if n_max == -1:
            break
        n_pos=form_aux.index(n_max)
        form_aux[n_pos]=-1
        if n_pos==0:
            rack_form[str(x)]+=1
        elif n_pos==1:
            azure_form[str(x)]+=1
        elif n_pos==2:
            amazon_form[str(x)]+=1
        elif n_pos==3:
            google_form[str(x)]+=1
        x+=1

    pg["rackspace"]=rack_pg
    pg["azure"]=azure_pg
    pg["amazon"]=amazon_pg
    pg["google"]=google_pg

    custo["rackspace"]=rack_custo
    custo["azure"]=azure_custo
    custo["amazon"]=amazon_custo
    custo["google"]=google_custo

    form["rackspace"]=rack_form
    form["azure"]=azure_form
    form["amazon"]=amazon_form
    form["google"]=google_form
    #req[line[1]]=
print("PG:",end=" ")
print(pg)
print("\nCusto:",end=" ")
print(custo)
print("\nFormula:",end=" ")
print(form)
