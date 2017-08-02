class AhpController < ApplicationController
    helper_method :hight_count, :width_hierarchy, :render_nodes

    def base
    end

    def render_nodes(node,tr,count)
        res=""
        if node.children.size==0
            tr=true
        end
        res<<"<td class='hier var' rowspan= #{width_hierarchy(node)}>"
        res<<node.name
        if node.weight!=0
            res<<"<input size='6' value=#{node.weight} disabled class='res'>"
        end
        node.children.each{
            |n| res<<render_nodes(Node.find_by_name(n.name),false,count)
        }
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
    
        #Cria os arquivos necessários para a execução do AHP (tree.hrc), caso a opção de pesos seja a custom, é necessário criar o arquivos custom.hrc.
        #É necessário passar como parâmetro de execução a opção de peso selecionada.
    end
end
