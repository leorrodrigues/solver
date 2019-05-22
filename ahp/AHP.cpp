#ifdef _WIN32
	#include "stdafx.h"
#endif
#include "AHP.h"

AHP::AHP(){
	hierarchy = new Tree();
}

AHP::AHP(const AHP &clone){
}

AHP::AHP(AHP *ptrClone){
}

AHP::~AHP(){
}

void AHP::Conception(int opt) {
	#ifdef DEBUG
	std::cout<<"##Option "<<opt<<"###################################################\n";
	#endif
	bool first=true;
	std::ifstream inputFileStream;
	#ifdef EXAMPLE
	std::ifstream inputFileStream("test/tree.hrc",std::ios::in);
	#else
	char cwd[1024];
	getcwd(cwd, sizeof(cwd));
	if(opt==7)
		strcat(cwd,"/ahp/tree/tree.hrc");
	else if(opt==8)
		strcat(cwd,"/ahp/tree/treeCost.hrc");
	else if(opt==9)
		strcat(cwd,"/ahp/tree/tree_vimam.hrc");
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
	std::cout<<"##################ACQUISITION####################\n";
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
	else if(option==9)
		strcat(cwd,"/ahp/weights/vimam.hrc");
	inputFileStream.open(cwd, std::ios::in);
	if (!inputFileStream.good()) {
		std::cout<<"Error in opening the file Ex2\n";
		return;
	}
	#endif
	while(std::getline(inputFileStream,line)) {
		std::istringstream lineStream(line);
		top=list.front();
		tam=top->child.size();
		if(tam==0) tam=hierarchy->alternatives.size();
		list.erase(list.begin());
		for(std::vector<Node *>::iterator it=top->child.begin(); it!=top->child.end(); it++) {
			if((*it)->name=="Alternatives") continue;
			list.push_back(*it);
		}
		top->board.resize(tam);
		for(int i=0; i<tam; i++)
			if(option!=9)
				top->board[i].resize(tam);
			else
				top->pml.resize(tam);
		i=j=0;
		while(std::getline(lineStream,value,';')) {
			if(option!=9)
				top->board[i][j]=std::stod(value);
			else{
				top->pml[j]=std::stod(value);
				std::cout<<"\tVALUE "<<value<<"#";
				printf("%lf",std::stod(value));
				std::cout<<"#"<<top->pml[j]<<"\n";
			}
			j++;
			if(j==tam) {j=0; i++;}
		}
		#ifdef DEBUG
		std::cout<<top->name<<std::endl;
		for(int i=0; i<tam; i++) {
			if(option!=9) {
				for(int j=0; j<tam; j++) {
					std::cout<<"\t"<<top->board[i][j];
				}
				std::cout<<std::endl;
			}else
				std::cout<<"\t"<<top->pml[i];
		}
		std::cout<<std::endl;
		#endif
	}
	#ifdef DEBUG
	std::cout<<"#######################################################\n";
	#endif
}

void AHP::Synthesis(int opt=0) {
	#ifdef DEBUG
	std::cout<<"#################SYNTHESIS OPT "<<opt<<" ########################\n";
	#endif
	//**********************************************************************
	//				Normalizing the tables of judgments
	//**********************************************************************
	std::vector<Node *> list; //O(1)
	Node *top=NULL; //O(1)
	double sum; //O(1)
	int tam; //O(1)
	list.push_back(hierarchy->root); //O(1)
	if(opt!=9) {
		while(!list.empty()) { //O(E) -> O(E+N**2+V)
			top=list.front(); //O(1)
			tam=top->child.size(); //O(1)
			if(tam==0) tam=hierarchy->alternatives.size(); //O(1)
			top->normalizedBoard.resize(tam); //O(n)
			for(int i=0; i<tam; i++) //O(N) -> O(N**2)
				top->normalizedBoard[i].resize(tam); //O(N)
			list.erase(list.begin()); //O(1)
			for(std::vector<Node *>::iterator it=top->child.begin(); it!=top->child.end(); it++) //O(V)
				list.push_back(*it); //O(1)

			for(int j=0; j<tam; j++) { //O(n) ->O(n**2)
				sum=0; //O(1)
				for(int i=0; i<tam; i++) //O(n)
					sum+=top->board[i][j]; //O(1)
				for(int i=0; i<tam; i++) //O(n)
					top->normalizedBoard[i][j]=top->board[i][j]/sum; //O(1)
			}
		}

		//**********************************************************************
		//				Building the PMLs
		//**********************************************************************
		list.clear(); //O(n)
		list.push_back(hierarchy->root);//O(1)
		while(!list.empty()) { //O(E) ->O(E+V)
			top=list.front(); //O(1)
			tam=top->child.size(); //O(1)
			if(tam==0) tam=hierarchy->alternatives.size(); //O(1)
			list.erase(list.begin()); //O(1)
			for(std::vector<Node *>::iterator it=top->child.begin(); it!=top->child.end(); it++) //O(V)
				list.push_back(*it); //O(1)
			for(int i=0; i<tam; i++) { //O(N)
				sum=0; //O(1)
				for(int j=0; j<tam; j++) //O(N)
					sum+=top->normalizedBoard[i][j]; //O(1)
				top->pml.push_back(sum/tam); //O(1)
			}
		#ifdef DEBUG
			std::cout<<top->name<<" ->PML: ";
			for(int i=0; i<tam; i++)
				std::cout<<top->pml[i]<<" ";
			std::cout<<std::endl<<std::endl;
		#endif
		}
	}
	//**********************************************************************
	//				Building the PGs
	//**********************************************************************
	tam=hierarchy->alternatives.size(); //O(1)
	pg.resize(tam); //O(n)
	pg=CalculatePG(hierarchy->root); //O(V+N*A)
	#ifdef DEBUG
	std::cout<<"PG: (";
	for(std::vector<double>::iterator it=pg.begin(); it!=pg.end(); it++)
		std::cout<<(*it)<<"; ";
	std::cout<<")."<<std::endl;
	std::cout<<"#######################################################\n";
	#endif
}

std::vector<double> AHP::CalculatePG(Node *node){ //O(V+N*A) //Where V is the lenght of children's node and A the size of the alternatives and N the size of the matrix
	std::vector<std::vector<double> > pgInd; //O(1)
	std::vector<double> pgCalc; //O(1)
	int k=0; //O(1)

	if(node->leaf) //O(1)
		return node->pml; //O(1)
	for(std::vector<Node *>::iterator it=node->child.begin(); it!=node->child.end(); it++) { //O(V)
		std::vector<double> a=CalculatePG(*it);
		pgInd.push_back(a); //O(1)
	}
	pgCalc.resize(hierarchy->alternatives.size()); //O(n)
	for(std::vector<double>::iterator it=node->pml.begin(); it!=node->pml.end(); it++) { //O(n)
		for(int i=0; i<hierarchy->alternatives.size(); i++) //O(a)
			pgCalc[i]+=((*it)*pgInd[k][i]); //O(1)
		k++; //O(1)
	}
	return pgCalc; //O(1)
}

std::vector<std::vector<double> >multiply(std::vector<std::vector<double> > board,std::vector<double> pml){ //O(n**2)
	int a=board.size(); //O(1)
	std::vector<std::vector<double> > matrix; //O(1)
	matrix.resize(a); //O(n)
	for(int i=0; i<a; i++) //O(n)
		matrix[i].resize(a); //O(n)
	for(int j=0; j<a; j++) { //O(n)
		for(int i=0; i<a; i++) { //O(n)
			matrix[i][j]=board[i][j]*pml[j]; //O(1)
		}
	}
	return matrix; //O(1)
}

void AHP::Consistency() {// Check the consistency of every board created.
	//Complexity O(V+N**2)
	#ifdef DEBUG
	std::cout<<"##################CONSISTENCY######################\n";
	#endif
	double ir[]= {0.0, 0.0, 0.0, 0.58, 0.9, 1.12, 1.24, 1.32, 1.41, 1.45, 1.49, 1.51, 1.48, 1.56, 1.57, 1.59};
	double lambda=0,IC=0,RC=0;
	std::vector<double> p,pAux;
	std::vector<std::vector<double> >aux;
	std::vector<Node *> list;
	Node *top;
	list.push_back(hierarchy->root); // O(1)
	while(!list.empty()) {
		lambda=IC=RC=0; //O(1)
		aux.clear(); //O(n)
		p.clear(); //O(n)
		pAux.clear(); //O(n)
		top=list.front(); //O(1)
		list.erase(list.begin()); //O(1)
		for(std::vector<Node *>::iterator it=top->child.begin(); it!=top->child.end(); it++) //O(V)
			list.push_back(*it);
		if(top->board.size()>2) { //O(N)
			aux=multiply(top->board,top->pml); //O(n**2)
			p.resize(aux.size()); //O(1)
			for(int i=0; i<aux.size(); i++) //O(N)
				for(int j=0; j<aux.size(); j++) // O(N)
					p[i]+=aux[i][j];
			pAux.resize(p.size()); //O(N)
			for(int i=0; i<p.size(); i++) //O(N)
				pAux[i]=p[i]/top->pml[i];
			for(int i=0; i<pAux.size(); i++) //O(N)
				lambda+=pAux[i];
			lambda/=pAux.size();
			IC=fabs(lambda-pAux.size())/(pAux.size()-1);
			RC=IC/ir[pAux.size()];
		}
		else{ //O(1)
			RC=IC=0;
		}
		#ifdef DEBUG
		std::cout<<"Matriz "<<top->name<<" apresenta RC de "<<RC<<", sendo o IC de "<<IC<<" e IR de "<<ir[pAux.size()]<<std::endl<<std::endl;
		#endif
		#ifndef TIME
		if(RC>=0.1) {
			std::cout<<"Matrix "<<top->name<<" are inconsistent, the RC is "<<RC<<" change the judgment weights and reexecute the method\n";
		}
		#endif
	}
	#ifdef DEBUG
	std::cout<<"#######################################################\n";
	#endif
}
