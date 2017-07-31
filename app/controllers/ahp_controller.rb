class AhpController < ApplicationController
  def base
  end

  def execute_ahp
    puts "Executando o código C++ do AHP"
    #Cria os arquivos necessários para a execução do AHP (tree.hrc), caso a opção de pesos seja a custom, é necessário criar o arquivos custom.hrc.
    #É necessário passar como parâmetro de execução a opção de peso selecionada.
  end
end
