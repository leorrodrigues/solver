/* Standard Includes */
#include <iostream>
#include <stdlib.h>
#include <locale.h>
#include <fstream>
#include <vector>
#include <chrono>
#include <ctime>
#include <map>

/* Multicriteria Methods Includes */
#include "AHP.h"

/* Tree Includes */
#include "Tree.h"

int Save(AHP *ptrAHP,char *name,int model){
	std::vector<Node *> list;
	std::ofstream file;
	Node *top=NULL;
	char nameF[1024];
	getcwd(nameF,sizeof(nameF));
	strcat(nameF,"/ahp/Results/");
	strcat(nameF,name);
	strcat(nameF,".hrc");
	file.open(nameF,std::ios::out|std::ios::app);
	if(file.is_open()){
		/**************************************************/
		/************WRITING MODELS IN FILE****************/
		/**************************************************/
		file << "Model:";
		if(model==1) file<<"Flat\n";
		else if(model==2) file<<"Segurança\n";
		else if(model==3) file<<"Rede\n";
		else if(model==4) file<<"QoS\n";
		else if(model==5) file<<"Hospedagem\n";
		else if(model==6) file<<"Comunicação\n";
		else if(model==7) file<<"Custom\n";
		else file<<"Cost\n";
		/**************************************************/
		/************WRITING PG IN FILE********************/
		/**************************************************/
		file <<"PG:"<< ptrAHP->hierarchy->alternatives.size()<<":";
		for(std::vector<double>::iterator it=ptrAHP->pg.begin();it!=ptrAHP->pg.end();it++)
			file <<(*it)<<" ";
		file<<"\n";
		/**************************************************/
		/************WRITING PMLS IN FILE******************/
		/**************************************************/
		list.push_back(ptrAHP->hierarchy->root);
		while(!list.empty()){
			top=list.front();
			list.erase(list.begin());
			for(std::vector<Node *>::iterator it=top->child.begin();it!=top->child.end();it++){
				if((*it)->name=="Alternatives") continue;
				list.push_back(*it);
			}
			if(top->child.size()==0){
				file<<"PML:"<<top->name<<":"<<ptrAHP->hierarchy->alternatives.size()<<":";
				for(int i=0;i<ptrAHP->hierarchy->alternatives.size();i++)
					file<<top->pml[i]<<";";
			}
			else{
				file<<"PML:"<<top->name<<":"<<top->child.size()<<":";
				for(int i=0;i<top->child.size();i++)
					file<<top->pml[i]<<";";
			}
			file<<"\n";

		}
		/**************************************************/
		/************WRITING MATRIX IN FILE****************/
		/**************************************************/
		list.clear();
		list.push_back(ptrAHP->hierarchy->root);
		while(!list.empty()){
			top=list.front();
			list.erase(list.begin());
			for(std::vector<Node *>::iterator it=top->child.begin();it!=top->child.end();it++){
				if((*it)->name=="Alternatives") continue;
				list.push_back(*it);
			}
			if(top->child.size()==0){
				file<<"Matrix:"<<top->name<<":"<<ptrAHP->hierarchy->alternatives.size()<<"\n";
				for(int i=0;i<ptrAHP->hierarchy->alternatives.size();i++)
					for(int j=0;j<ptrAHP->hierarchy->alternatives.size();j++)
						file<<top->board[i][j]<<";";
			}
			else{
				file<<"Matrix:"<<top->name<<":"<<top->child.size()<<"\n";
				for(int i=0;i<top->child.size();i++)
					for(int j=0;j<top->child.size();j++)
						file<<top->board[i][j]<<";";
			}
			file<<"\n";
		}
		/**************************************************/
		/************WRITING NORMALIZED MATRIX IN FILE*****/
		/**************************************************/
		list.clear();
		list.push_back(ptrAHP->hierarchy->root);
		while(!list.empty()){
			top=list.front();
			list.erase(list.begin());
			for(std::vector<Node *>::iterator it=top->child.begin();it!=top->child.end();it++){
				if((*it)->name=="Alternatives") continue;
				list.push_back(*it);
			}
			if(top->child.size()==0){
				file<<"Normalized:"<<top->name<<":"<<ptrAHP->hierarchy->alternatives.size()<<"\n";
				for(int i=0;i<ptrAHP->hierarchy->alternatives.size();i++)
					for(int j=0;j<ptrAHP->hierarchy->alternatives.size();j++)
						file<<top->normalizedBoard[i][j]<<";";
			}
			else{
				file<<"Normalized:"<<top->name<<":"<<top->child.size()<<" \n";
				for(int i=0;i<top->child.size();i++)
					for(int j=0;j<top->child.size();j++)
						file<<top->normalizedBoard[i][j]<<";";
			}
			file<<"\n";
		}
		/**************************************************/
		/************WRITING Alternatives IN FILE**********/
		/**************************************************/
		file<<"Alternatives:";
		for(std::vector<Node *>::iterator it=ptrAHP->hierarchy->alternatives.begin();it!=ptrAHP->hierarchy->alternatives.end();it++){
			file<<(*it)->name<<";";
		}
		file<<"\n";
		file.close();
	}
	return 0;
}

std::vector<double> CalcReq(std::vector<int> req){
	std::vector<double> valueReq;
	std::vector<std::vector<double> >cost;
	std::vector<double> alternative1={27,4.75,4.75,0.1};
	cost.push_back(alternative1);
	std::vector<double> alternative2={29.4,5.1,4.87,0.07};
	cost.push_back(alternative2);
	std::vector<double> alternative3={25.43,7.9,8.64,0.023};
	cost.push_back(alternative3);
	std::vector<double> alternative4={24.27,9.1,3.35,0.054};
	cost.push_back(alternative4);
	double sum=0,x;
	for(int i=0;i<4;i++){//You`ve to change the value 4 according to the size of alternatives that you have
		for(int j=0;j<4;j++){//This value 4 corresponds to the size of your requisition, that is your quadruple (VM,CPU,RAM,STORAGE).
			sum+=req[j]*cost[i][j];
		}
		while(sum>1.0)
			sum/=10;
		valueReq.push_back(sum);
		x+=sum;
		sum=0;
	}
	for(int i=0;i<4;i++){//You`ve to change the value 4 according to the size of alternatives that you have
		valueReq[i]/=x;
	}
	return valueReq;
}

int GenerateValues(AHP *ptrAHP,char *name,int model,std::vector<int> req,std::vector<double> cost){
	std::ofstream file;
	char nameF[1024];
	getcwd(nameF,sizeof(nameF));
	strcat(nameF,"/ahp/analysis/");
	strcat(nameF,"results");
	strcat(nameF,".hrc");
	file.open(nameF,std::ios::out|std::ios::app);
	if(file.is_open()){
		file<<name<<" - ";
		if(model==1) file<<"Flat - ";
		else if(model==2) file<<"Segurança - ";
		else if(model==3) file<<"Rede - ";
		else if(model==4) file<<"QoS - ";
		else if(model==5) file<<"Hospedagem - ";
		else if(model==6) file<<"Comunicação - ";
		else if(model==7) file<<"Custom - ";
		else file<<"Cost - ";
		//Qualidade
		for(std::vector<double>::iterator it=ptrAHP->pg.begin();it!=ptrAHP->pg.end();it++)
			file <<(*it)<<";";

		//Custo
		file<<" - ";
		std::vector<double> valueReq=CalcReq(req); //vector of doubles, which each element corresponds the value of the requisition on determined alternative (EX: (0.34 -> AWS,0.29 -> Google,0.398 ->Microsoft,0.6 ->Rackspace) )
		for(std::vector<double>::iterator it=valueReq.begin();it!=valueReq.end();it++)
			file<<(*it)<<";";

		//Formula
		file<<" - ";
		for(int i=0;i<ptrAHP->pg.size();i++)
			file<<(ptrAHP->pg[i]*0.4+cost[i]*0.25+valueReq[i]*0.35)<<";";
		file<<"\n";
		file.close();
	}
}

int main(int argc,char *argv[]){//O(C*(E*(N**2+V)+E*N**2+N*A)) -> O(N**4)
	setlocale(LC_ALL, "");
	#ifdef TIME
		double total=0;
		//for(int vezes=0;vezes<10;vezes++){
		std::chrono::high_resolution_clock::time_point t1 = std::chrono::high_resolution_clock::now();
	#endif
	//argv[0] = nome programa
	//argv[1] = nome arquivo
	//argv[2...5] = Tupla(MV CPU RAM STORAGE)
	//argv[6..final] = Cenário
	#ifdef ANALYSIS
		std::vector<double> cost;
		std::vector<int> req={atoi(argv[2]),atoi(argv[3]),atoi(argv[4]),atoi(argv[5])};
		for(int i=6;i<argc;i++){
	#else
		for(int i=2;i<argc;i++){
	#endif
		AHP	*ptrAHP = new AHP();

		ptrAHP->Conception(atoi(argv[i])); //O(N**2)

		ptrAHP->Acquisition(atoi(argv[i])); //O(N**2)

		ptrAHP->Synthesis(); //O(E*N**2+N*A)

		ptrAHP->Consistency(); //O(E*(N**2+V))

		#ifdef ANALYSIS
			if(atoi(argv[i])==8)
				cost=ptrAHP->pg;
			else
				GenerateValues(ptrAHP,argv[1],atoi(argv[i]),req,cost);
		#else
			Save(ptrAHP,argv[1],atoi(argv[i]));
		#endif

	}
	#ifdef TIME
		std::chrono::high_resolution_clock::time_point t2 = std::chrono::high_resolution_clock::now();
		std::chrono::duration<double, std::milli> time_span = t2 - t1;
		//}
		std::cout << "It took me " << time_span.count() << " milliseconds in media."<< std::endl;
	#endif
	return 0;
}
