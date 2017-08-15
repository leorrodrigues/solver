class ResultController < ApplicationController
    helper_method :create_kiviat,:show_results,:get_modules,:get_axis,:get_data

    def index
        @number=params[:number]
        @cloud = params[:id]
        @results= Array.new
        if load_file @number
            flash[:notice]="AHP Executado com sucesso"
        else
            flash[:error]="Não foi possível realizar a execução do AHP"
            redirect_to ahp_base_path
        end
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
                end
                if !pml.empty?
                    x.push("PML"=>pml)
                    pml=[]
                end
                if !matrix.empty?
                    x.push("Matrix"=>matrix)
                    matrix=[]
                end
                if !normalized.empty?
                    x.push("Normalized"=>normalized)
                    normalized=[]
                end
                if !x.empty?
                    @results.push(model => x)
                end
                model=parse[1].split("\n")
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
        @results.push(model => x)
        #puts(@@results)
        if @results.size()!=0
            true
        else
            false
        end
    end

    def create_kiviat(chartName,model,category,data)
        res=""
        res<<"<title>KIVIAT GRAPH</title><script type=\"text/javascript\" src=\"http://static.fusioncharts.com/code/latest/fusioncharts.js\"></script> <script type=\"text/javascript\" src=\"http://static.fusioncharts.com/code/latest/themes/fusioncharts.theme.fint.js?cacheBust=56\"></script><script type=\"text/javascript\"> FusionCharts.ready(function(){ var fusioncharts = new FusionCharts({ type: 'radar', renderAt: 'chart-container', width: '600', height: '450', dataFormat: 'json', dataSource: { \"chart\": {\"caption\": \"#{chartName}\",\"numberPreffix\": \"$\", \"theme\": \"fint\", \"radarfillcolor\": \"#ffffff\" }, \"categories\": [{ \"category\": ["

        category.each do |c|
            res<<"{\"label\": \"#{c}\"}"
            if c!=category.last
                res<<", "
            end
        end
        res<<"]}], \"dataset\": [{"
        i=0
        model.each do |m|
            res<<"\"seriesname\": \"#{m}\", \"data\": ["
            (0...data[i].size).each do |v|
                res<<"{\"value\": \"#{data[i][v]}\"}"
                if v!=data[i].size-1
                    res<<","
                end
            end
            if m!=model.last
                res<<"]},{ "
            end
            i+=1
        end
        res<<"]}]}}); fusioncharts.render(); }); </script><div id=\"chart-container\">FusionCharts XT will load here!</div> "
        res
    end

    def show_results
        @results
    end

    def get_modules
    end

    def get_axis
    end

    def get_data
    end

end
