#ifdef _WIN32
	#include "stdafx.h"
#endif
#include "Tree.h"

Node *Tree::search(std::string key){
	std::vector<Node *>list;
	Node *top;
	list.push_back(root);
	while(!list.empty()){
		top=list.front();
		list.erase(list.begin());
		if(top->name==key) return top;
		for(std::vector<Node *>::iterator it=top->child.begin();it!=top->child.end();it++){
			list.push_back(*it);
		}
	}
	return NULL;
}

void Tree::add(Node *parent,Node *child){
	parent->child.push_back(child);
}

void Tree::printTreeWeights(Node *node, int tab) {
	for (int i = 0; i < tab; i++) printf("\t");
	std::cout<<"Name "<<node->name<<" - Weight: "<<node->weight<<" - Level: "<<node->height<<std::endl;
	if (!node->child.empty())
		for (std::vector<Node *>::iterator it = node->child.begin(); it != node->child.end(); it++) {
			printTreeWeights(*it, tab += 1);
		}
}

void Tree::printTree(Node *node, int tab) {
	for (int i = 0; i < tab; i++) printf("\t");
	std::cout<<node->name<<std::endl;
	if (!node->child.empty())
		for (std::vector<Node *>::iterator it = node->child.begin(); it != node->child.end(); it++)
			if(!(*it)->leaf)
				printTree(*it, tab+1);
}

void Tree::printAlternatives(){
	for(std::vector<Node *>::iterator it=alternatives.begin();it!=alternatives.end();it++){
		for(int i=0;i<height;i++) printf("\t");
		std::cout<<(*it)->name<<std::endl;
	}
}
