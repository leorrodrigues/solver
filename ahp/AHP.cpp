#ifdef _WIN32
	#include "stdafx.h"
#endif
#include "AHP.h"

AHP::AHP(){
	hierarchy = new Tree();
}

AHP::AHP(const AHP &clone){}

AHP::AHP(AHP *ptrClone){}

AHP::~AHP(){}

void AHP::Conception(int opt) {
	#ifdef DEBUG
		std::cout<<"#######################################################\n";
	#endif
	bool first=true;
	std::ifstream inputFileStream;
	#ifdef EXAMPLE
		std::ifstream inputFileStream("test/tree.hrc",std::ios::in);
	#else
		char cwd[1024];
   		getcwd(cwd, sizeof(cwd));
		if(opt==7)
			strcat(cwd,"/ahp/tree/tree_custom.hrc");
		else if(opt==8)
			strcat(cwd,"/ahp/tree/treeCost.hrc");
		else
			strcat(cwd,"/ahp/tree/tree.hrc");
		inputFileStream.open(cwd, std::ios::in);
	#endif
	if (!inputFileStream.good()) {
		std::cerr<<"Error in opening the file E0x1\n";
		return;
	}
	std::string line, name,nameChild;
	while (std::getline(inputFileStream,line)) {
		Node *node= new Node();
		std::istringstream lineStream(line);
		std::getline(lineStream, name, ':');
		name = std::regex_replace(name, std::regex("^ +| +$|( ) +"), "$1");
		if(first) {
			node->name=name;
			node->height=0;
			node->weight=0;
			node->parent=NULL;
			node->leaf=true;
			hierarchy->root=node;
			first=false;
		}
		if(name!="Alternatives")
			while (std::getline(lineStream, nameChild, ';')) {
				Node *child=new Node();
				nameChild=std::regex_replace(nameChild, std::regex("^ +| +$|( ) +"), "$1");
				if(nameChild=="Alternatives") continue;
				Node *parent=hierarchy->search(name);
				child->name=nameChild;
				parent->leaf=false;
				child->parent=parent;
				child->leaf=true;
				child->weight=0;
				child->height=parent->height+1;
				if(hierarchy->height<child->height) hierarchy->height=child->height;
				hierarchy->add(parent,child);
			}
		else
			while (std::getline(lineStream, nameChild, ';')) {
				nameChild=std::regex_replace(nameChild, std::regex("^ +| +$|( ) +"), "$1");
				Node *alt=new Node();
				alt->name=nameChild;
				alt->height=hierarchy->height;
				alt->weight=0;
				alt->parent=NULL;
				alt->leaf=false;
				hierarchy->alternatives.push_back(alt);
			}
	}
	#ifdef DEBUG
		std::cout<<"#######################################################\n";
	#endif
}

void AHP::Acquisition(int option) { // Put the weights on the criterias of the hierarchy.
	#ifdef DEBUG
		std::cout<<"#######################################################\n";
	#endif
	std::vector<Node *> list;
	int i,j,tam=0;
	std::string line,value;
	Node *top=NULL;
	list.push_back(hierarchy->root);
	std::ifstream inputFileStream;
	char cwd[1024];
	getcwd(cwd, sizeof(cwd));
	#ifdef EXAMPLE
		strcat(cwd,"/ahp/test/weights.hrc");
	#else
		if(option==1)
			strcat(cwd,"/ahp/weights/flat.hrc");
		else if(option==2)
			strcat(cwd,"/ahp/weights/security.hrc");
		else if(option==3)
			strcat(cwd,"/ahp/weights/wire.hrc");
		else if(option==4)
			strcat(cwd,"/ahp/weights/QoS.hrc");
		else if(option==5)
			strcat(cwd,"/ahp/weights/host.hrc");
		else if(option==6)
			strcat(cwd,"/ahp/weights/expert.hrc");
		else if(option==7)
			strcat(cwd,"/ahp/weights/custom.hrc");
		else if(option==8)
			strcat(cwd,"/ahp/weights/cost.hrc");
		inputFileStream.open(cwd, std::ios::in);
		if (!inputFileStream.good()) {
			std::cout<<"Error in opening the file Ex2\n";
			return;
		}
	#endif
	while(std::getline(inputFileStream,line)){
		std::istringstream lineStream(line);
		top=list.front();
		tam=top->child.size();
		if(tam==0) tam=hierarchy->alternatives.size();
		list.erase(list.begin());
		for(std::vector<Node *>::iterator it=top->child.begin();it!=top->child.end();it++){
			if((*it)->name=="Alternatives") continue;
			list.push_back(*it);
		}
		top->board.resize(tam);
		for(int i=0;i<tam;i++)
			top->board[i].resize(tam);
		i=j=0;
		while(std::getline(lineStream,value,';')){
			top->board[i][j]=stod(value);
			j++;
			if(j==tam){j=0;i++;}
		}
		#ifdef DEBUG
			std::cout<<top->name<<std::endl;
			for(int i=0;i<tam;i++){
				for(int j=0;j<tam;j++){
					std::cout<<"\t"<<top->board[i][j];
				}
				std::cout<<std::endl;
			}
			std::cout<<std::endl;
		#endif
	}
	#ifdef DEBUG
		std::cout<<"#######################################################\n";
	#endif
}

void AHP::Synthesis() {
	#ifdef DEBUG
		std::cout<<"#######################################################\n";
	#endif
	//**********************************************************************
	//				Normalizing the tables of judgments
	//**********************************************************************
	std::vector<Node *> list;
	list.push_back(hierarchy->root);
	Node *top=NULL;
	double sum;
	int tam;
	while(!list.empty()){
		top=list.front();
		tam=top->child.size();
		if(tam==0) tam=hierarchy->alternatives.size();
		top->normalizedBoard.resize(tam);
		for(int i=0;i<tam;i++)
			top->normalizedBoard[i].resize(tam);
		list.erase(list.begin());
		for(std::vector<Node *>::iterator it=top->child.begin();it!=top->child.end();it++)
			list.push_back(*it);

		for(int j=0;j<tam;j++){
			sum=0;
			for(int i=0;i<tam;i++)
				sum+=top->board[i][j];
			for(int i=0;i<tam;i++)
				top->normalizedBoard[i][j]=top->board[i][j]/sum;
		}
	}
	//**********************************************************************
	//				Building the PMLs
	//**********************************************************************
	list.clear();
	list.push_back(hierarchy->root);
	while(!list.empty()){
		top=list.front();
		tam=top->child.size();
		if(tam==0) tam=hierarchy->alternatives.size();
		list.erase(list.begin());
		for(std::vector<Node *>::iterator it=top->child.begin();it!=top->child.end();it++)
			list.push_back(*it);
		for(int i=0;i<tam;i++){
			sum=0;
			for(int j=0;j<tam;j++)
				sum+=top->normalizedBoard[i][j];
			top->pml.push_back(sum/tam);
		}
		#ifdef DEBUG
			std::cout<<top->name<<" ->PML: ";
			for(int i=0;i<tam;i++)
				std::cout<<top->pml[i]<<" ";
			std::cout<<std::endl<<std::endl;
		#endif
	}
	//**********************************************************************
	//				Building the PGs
	//**********************************************************************
	tam=hierarchy->alternatives.size();
	pg.resize(tam);
	pg=CalculatePG(hierarchy->root);
	#ifdef DEBUG
		std::cout<<"PG: (";
		for(std::vector<double>::iterator it=pg.begin();it!=pg.end();it++)
			std::cout<<(*it)<<"; ";
		std::cout<<")."<<std::endl;
		std::cout<<"#######################################################\n";
	#endif
}

std::vector<double> AHP::CalculatePG(Node *node){
	std::vector<std::vector<double> > pgInd;
	std::vector<double> pgCalc;
	int k=0;

	if(node->leaf)
		return node->pml;
	for(std::vector<Node *>::iterator it=node->child.begin();it!=node->child.end();it++){
		std::vector<double> a=CalculatePG(*it);
		pgInd.push_back(a);
	}
	pgCalc.resize(hierarchy->alternatives.size());
	for(std::vector<double>::iterator it=node->pml.begin();it!=node->pml.end();it++){
		for(int i=0;i<hierarchy->alternatives.size();i++)
			pgCalc[i]+=((*it)*pgInd[k][i]);
		k++;
	}
	return pgCalc;
}

std::vector<std::vector<double> >multiply(std::vector<std::vector<double> > board,std::vector<double> pml){
	int a=board.size();
	std::vector<std::vector<double> > matrix;
	matrix.resize(a);
	for(int i=0;i<a;i++)
		matrix[i].resize(a);
	for(int j=0;j<a;j++){
		for(int i=0;i<a;i++){
			matrix[i][j]=board[i][j]*pml[j];
		}
	}
	return matrix;
}

void AHP::Consistency() {// Check the consistency of every board created.
	#ifdef DEBUG
		std::cout<<"#######################################################\n";
	#endif
	double ir[]= {0.0, 0.0, 0.0, 0.58, 0.9, 1.12, 1.24, 1.32, 1.41, 1.45, 1.49, 1.51, 1.48, 1.56, 1.57, 1.59};
	double lambda=0,IC=0,RC=0;
	std::vector<double> p,pAux;
	std::vector<std::vector<double> >aux;
	std::vector<Node *> list;
	Node *top;
	list.push_back(hierarchy->root);
	while(!list.empty()){
		lambda=IC=RC=0;
		aux.clear();
		p.clear();
		pAux.clear();
		top=list.front();
		list.erase(list.begin());
		for(std::vector<Node *>::iterator it=top->child.begin();it!=top->child.end();it++)
			list.push_back(*it);
		if(top->board.size()>2){
			aux=multiply(top->board,top->pml);
			p.resize(aux.size());
			for(int i=0;i<aux.size();i++)
				for(int j=0;j<aux.size();j++)
					p[i]+=aux[i][j];
			pAux.resize(p.size());
			for(int i=0;i<p.size();i++)
				pAux[i]=p[i]/top->pml[i];
			for(int i=0;i<pAux.size();i++)
				lambda+=pAux[i];
			lambda/=pAux.size();
			IC=fabs(lambda-pAux.size())/(pAux.size()-1);
			RC=IC/ir[pAux.size()];
		}
		else{
			RC=IC=0;
		}
		#ifdef DEBUG
			std::cout<<"Matriz "<<top->name<<" apresenta RC de "<<RC<<", sendo o IC de "<<IC<<" e IR de "<<ir[pAux.size()]<<std::endl<<std::endl;
		#endif
		if(RC>=0.1){
			std::cout<<"Matrix "<<top->name<<" are inconsistent, the RC is "<<RC<<" change the judgment weights and reexecute the method\n";
		}
	}
	#ifdef DEBUG
		std::cout<<"#######################################################\n";
	#endif
}
