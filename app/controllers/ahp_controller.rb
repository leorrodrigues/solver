class AhpController < ApplicationController
    helper_method :hight_count, :width_hierarchy, :render_nodes, :checkUP

    @@forms="flat"
    @@option=["flat"]

    def base
        @ahps = Category.all
        respond_to do |format|
            format.js
            format.html
        end
    end

    def renderForm
        @@forms=params[:name][0]
        @@option=params[:name]
        respond_to do |format|
            format.js{render(:partial => '_form_tree')}
        end
    end

    def render_nodes(node,tr,count)
        res=""
        if !node.nil?
            if node.children.size==0
                tr=true
            end
            res<<"<td class='hier var' rowspan= #{width_hierarchy(node)}>"
            res<<node.name
            if node.weight!=0
                res<<"<input size='6' value=#{node.weight} disabled class='res'>"
            end
            node.children.each do |n|
                x=Node.where(name:n.name,category_id:(Category.where(name: @@forms.downcase)))
                res<<render_nodes(x[0],false,count)
            end
            res<< "</td>"
            if node.children.size==0
                (0..(count-node.hight-1)).each do
                    res<<"<td></td>"
                end
            end
            if tr
                res<<"</tr>"
                if @even
                    res<<"<tr class='even'>"
                else
                    res<<"<tr class='odd'>"
                end
                @even=!@even
            end
        end
        res
    end

    def width_hierarchy(n)
        width=1
        a=[n]
        until a.empty?
            node=a[0]
            width+=node.children.size
            a.shift
            if not node.children.empty?
                width-=1
            end
            node.children.each do |child|
                a<<Node.find_by_name(child.name)
            end
        end
        if width==0
            width=1
        end
        width
    end

    def hight_count
        max=0
        a=[]
        a << Node.first
        until a.empty?
            node=a[0]
            if max<node.hight
                max=node.hight
            end
            a.shift
            node.children.each do |child|
                a<<Node.find_by_name(child.name)
            end
        end
        max
    end

    def execute_ahp
        op=""
        id = Identity.new
        numberFile= Identity.last
        id.number=numberFile.number+1
        id.save
        op<<String(numberFile.number)<<" ";
        @@option.each do |x|
            x=x.downcase
            if x=="flat"
                op<<"1 "
            elsif x=="segurança"
                op<<"2 "
            elsif x=="rede"
                op<<"3 "
            elsif x=="qos"
                op<<"4 "
            elsif x=="hospedagem"
                op<<"5 "
            elsif x=="comunicação"
                op<<"6 "
            elsif x=="custom"
                op<<"7 "
            end
        end
        result=`./ahp/solver #{op}`
        if result
            load_file numberFile.number
            #abrir arquivo com nome numberFile presente em /ahp/results/numberFile
            #ler os dados do arquivo
            #mandar para a view results
            #o controller results que deve se virar com os dados apresentados
            flash[:notice]="AHP Executado com sucesso"
        else
            flash[:error]="Não foi possível realizar a execução do AHP"
        end
    end

    def load_file(name)
        #The results array have: ModelName => [{PG},{PML},{MATRIX},{NORMALIZED}]
        model=""
        x=[]
        pg=[]
        pml=[]
        matrix=[]
        results=[]
        normalized=[]
        infile=File.open(Dir.pwd+"/ahp/Results/"+String(name)+".hrc","r")
        while(line=infile.gets)
            parse=line.split(":")
            if parse[0]=="Model"
                if !pg.empty?
                    x.push("PG"=>pg)
                    pg=[]
                elsif !pml.empty?
                    x.push("PML"=>pml)
                    pml=[]
                elsif !matrix.empty?
                    x.push("Matrix"=>matrix)
                    matrix=[]
                elsif !normalized.empty?
                    x.push("Normalized"=>normalized)
                    normalized=[]
                elsif !x.empty?
                    results.push(model => x)
                end
                model=parse[1]
                x=[]
            elsif parse[0]=="PG"
                tam=parse[1].to_i
                parse[2]=parse[2].split
                (0...tam).each do |value|
                    pg.push(parse[2][value])
                end

            elsif parse[0]=="PML"
                name=parse[1]
                tam=parse[2].to_i
                aux_pml=[]
                parse[3]=parse[3].split(";")
                (0...tam).each do |value|
                    aux_pml.push(parse[3][value])
                end
                pml.push(name=>aux_pml)

            elsif parse[0]=="Matrix"
                name=parse[1]
                tam=parse[2].to_i
                line=infile.gets
                parse=line.split(";")
                sub_matrix=[]
                aux_matrix=[]
                count=0
                (0...tam*tam).each do |value|
                    sub_matrix.push(parse[value])
                    count+=1
                    if(tam-1==count)
                        aux_matrix.push(sub_matrix[0].to_f)
                        sub_matrix=[]
                        count=0
                    end
                end
                matrix.push(name=>aux_matrix)

            elsif parse[0]=="Normalized"
                name=parse[1]
                tam=parse[2].to_i
                line=infile.gets
                parse=line.split(";")
                sub_matrix=[]
                aux_normalized=[]
                count=0
                (0...tam*tam).each do |value|
                    sub_matrix.push(parse[value])
                    count+=1
                    if(tam-1==count)
                        aux_normalized.push(sub_matrix[0].to_f)
                        sub_matrix=[]
                        count=0
                    end
                end
                normalized.push(name=>aux_normalized)
            end
        end
        x.push("PG"=>pg)
        x.push("PML"=>pml)
        x.push("Matrix"=>matrix)
        x.push("Normalized"=>normalized)
        results.push(model => x)
        puts(results)
    end

end
