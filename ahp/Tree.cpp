#ifdef _WIN32
	#include "stdafx.h"
#endif
#include "Tree.h"

Node *Tree::search(std::string key){ // O(|E|+|V|) where V its all the children of a node and E its all the nodes of the tree
	std::vector<Node *>list; //O(1)
	Node *top; //O(1)
	list.push_back(root); //O(1)
	while(!list.empty()){ //O(E) where n is all nodes of the three
		top=list.front(); //O(1)
		list.erase(list.begin()); //O(1)
		if(top->name==key) return top; //O(1)
		for(std::vector<Node *>::iterator it=top->child.begin();it!=top->child.end();it++){ //O(V)
			list.push_back(*it); //O(1)
		}
	}
	return NULL;
}

void Tree::add(Node *parent,Node *child){ //O(1)
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
