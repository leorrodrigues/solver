class AhpController < ApplicationController
    helper_method :hight_count, :width_hierarchy, :render_nodes, :checkUP

    @@forms="flat"
    @@option=["flat"]
    @@results=[]

    def base
        @ahps = Category.all
        @cloud = params[:id]
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

    def render_nodes(node,tr,count,cost=false)
        res=""
        if !node.nil?
            if node.children.size==0
                tr=true
            end
            if cost
                res<<"<td class='hier var' rowspan= #{width_hierarchy(node,true)}>"
            else
                res<<"<td class='hier var' rowspan= #{width_hierarchy(node)}>"
            end
            res<<node.name
            if node.weight!=0
                res<<"<input size='6' value=#{node.weight} disabled class='res'>"
            end
            node.children.each do |n|
                if cost
                    x=Node.where(name:n.name,category_id:(Category.where(name: "cost")))
                    res<<render_nodes(x[0],false,count,true)
                else
                    x=Node.where(name:n.name,category_id:(Category.where(name: @@forms.downcase)))
                    res<<render_nodes(x[0],false,count)
                end
            end
            res<< "</td>"
            if node.children.size==0
                if cost
                    (0..(count-node.hight-2)).each do
                        res<<"<td></td>"
                    end
                else
                    (0..(count-node.hight-1)).each do
                        res<<"<td></td>"
                    end
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

    def width_hierarchy(n,cost=false)
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
                if cost
                    a<<Node.where(name: child.name, category: Category.where(name: "cost"))[0]
                else
                    a<<Node.where(name: child.name)[0]
                end
            end
        end
        if width==0
            width=1
        end
        width
    end

    def hight_count(cost=false)
        max=0
        a=[]
        if cost
            a << Node.where(name:"Qual é o provedor de serviço com menor custo?")[0]
        else
            a << Node.first
        end
        until a.empty?
            node=a[0]
            if max<node.hight
                max=node.hight
            end
            a.shift
            node.children.each do |child|
                if cost
                    a<<Node.where(name: child.name, category: Category.where(name: "cost"))[0]
                else
                    a<<Node.where(name: child.name)[0]
                end
            end
        end
        max
    end

    def execute_ahp()
        cloudId = params[:cloudId]
        require 'securerandom'
        op=""
        id = Identity.new
        numberFile= Identity.last
        id.number=numberFile.number+1
        id.save
        fileName=SecureRandom.hex(8)+String(numberFile.number)+SecureRandom.hex(10)
        op<<fileName<<" ";
        op<<"8 "
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
        puts result #Faz a chamada do AHP -.-' hehehe '
        if result
            redirect_to result_index_path(:id=>cloudId,:number=> fileName)
        else
            flash[:error]="Não foi possível realizar a execução do AHP"
        end
    end



end
