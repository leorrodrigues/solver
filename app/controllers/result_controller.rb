class ResultController < ApplicationController
    helper_method :create_kiviat, :show_results, :get_models,:get_axis, :get_data, :get_alternatives, :req_sum, :calculate

    def index
        @number=params[:number]
        @cloud = params[:id]
        @results= Hash.new
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
        x=Hash.new
        pg=[]
        pml=Hash.new
        matrix=Hash.new
        normalized=Hash.new
        alternatives=Array.new
        infile=File.open(Dir.pwd+"/ahp/Results/"+String(name)+".hrc","r")
        while(line=infile.gets)
            parse=line.split(":")
            if parse[0]=="Model"
                if !pg.empty?
                    x["PG"]=pg
                    pg=[]
                end
                if !pml.empty?
                    x["PML"]=pml
                    pml=Hash.new
                end
                if !matrix.empty?
                    x["Matrix"]=matrix
                    matrix=Hash.new
                end
                if !normalized.empty?
                    x["Normalized"]=normalized
                    normalized=Hash.new
                end
                if !alternatives.empty?
                    x["Alternatives"]=alternatives
                    alternatives=Array.new
                end
                if !x.empty?
                    @results[model] = x
                end
                model=parse[1].split("\n")[0]
                x=Hash.new
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
                pml[name]=aux_pml

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
                matrix[name]=aux_matrix

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
                normalized[name]=aux_normalized

            elsif parse[0]=="Alternatives"
                parse[1]=parse[1].split(";")
                parse[1].each do |value|
                    if value!="\n"
                        alternatives<<value
                    end
                end
            end

        end
        x["PG"]=pg
        x["PML"]=pml
        x["Matrix"]=matrix
        x["Normalized"]=normalized
        x["Alternatives"]=alternatives
        @results[model] = x
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

    def get_alternatives(model)
        @results[model]["Alternatives"]
    end

    def get_models
        @results.keys
    end

    def get_axis
        @results["Flat"]["Matrix"].keys
    end

    def get_data(model)
        dt=[]
        data=@results[model]["PG"]
        data.each do |value|
            dt<<value.to_f
        end
        dt
    end

    def req_sum(alternative)
        #req[model]=>(vm,cpu,ram,storage))
        costs={"Amazon AWS"=>[1,1,1,1],"Google Cloud"=>[1,1,1,1],"Microsoft Azure"=>[1,1,1,1],"RackSpace"=>[1,1,1,1]}
        req=Cloud.where(id: @cloud)[0]
        sum=0.0
        sum+=req.vm*costs[alternative][0]
        sum+=req.cpu*costs[alternative][1]
        sum+=req.ram*costs[alternative][2]
        sum+=req.storage*costs[alternative][3]

        while(sum.to_f>1.0)
            sum=sum.to_f/10
        end
        sum
    end

    def calculate
        result=Array.new
        data=Hash.new
        cost=[]
        models=get_models
        alternatives=get_alternatives(models[0])
        models.each do |m|
            if m!="Cost"
                data[m]=get_data(m)
            else
                cost=get_data(m)
            end
        end
        models.each do |m|
            if m!="Cost"
                arr=Array.new
                (0...alternatives.size).each do |i|
                    arr<<(data[m][i]*0.5+cost[i]*0.3+req_sum(alternatives[i])*0.2)
                end
                result<<arr
            end
        end
        result
    end

end
