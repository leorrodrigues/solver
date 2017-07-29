#pragma once

#include <vector>
#include <cstdio>
#include <string>
#include <iostream>
#include <assert.h>

struct Node{
	std::string name;
	int height;
	bool leaf;
	double weight;
	Node *parent;
	std::vector<Node *> child;

	std::vector<std::vector<double>> board,normalizedBoard;
	std::vector<double> pml,pg;
};

class Tree{
public:
	Node *root;
	int height;
	std::vector<Node *> alternatives;
	Tree(){
		root=NULL;
		height=0;
	};

	~Tree();

	Node *search(std::string key);

	void add(std::string,Node *);
	void add(Node *,Node *);

	void printAlternatives();

	void printTree(){
		//std::cout<<root->name<<std::endl;
		printTree(root,0);
		printAlternatives();
	};

	void printTreeWeights(){
		std::cout<<"Name: "<<root->name<<std::endl;
		return printTreeWeights(root,0);
	};

private:
	void printTree(Node *, int);
	void printTreeWeights(Node *, int);
};
