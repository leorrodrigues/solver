class ResultController < ApplicationController

    @@results=[]

    def index
        @number=params[:number]
        if load_file @number
            flash[:notice]="AHP Executado com sucesso"
        else
            flash[:error]="Não foi possível realizar a execução do AHP"
            redirect_to ahp_base_path
        end
        puts @@results
    end

    def load_file(name)
        #The results array have: ModelName => [{PG},{PML},{MATRIX},{NORMALIZED}]
        model=""
        x=[]
        pg=[]
        pml=[]
        matrix=[]
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
                    @@results.push(model => x)
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
        @@results.push(model => x)
        #puts(@@results)
        if @@results.size()!=0
            true
        else
            false
        end
    end

end
