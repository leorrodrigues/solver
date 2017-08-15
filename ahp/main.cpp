/* Standard Includes */
#include <iostream>
#include <stdlib.h>
#include <locale.h>
#include <fstream>

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
		file.close();
	}
	return 0;
}

int main(int argc,char *argv[]){
	setlocale(LC_ALL, "");
	for(int i=2;i<argc;i++){
		AHP	*ptrAHP = new AHP();

		ptrAHP->Conception(atoi(argv[i]));

		ptrAHP->Acquisition(atoi(argv[i]));

		ptrAHP->Synthesis();

		ptrAHP->Consistency();

		Save(ptrAHP,argv[1],atoi(argv[i]));
	}

	return 0;
}
