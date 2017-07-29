#pragma once

#include "Method.h"
#include <assert.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <cstdlib>
#include <cmath>
#include <vector>
#include "Tree.h"
#include <regex>

class AHP : public Method {
public:
	Tree *hierarchy;
	std::vector<double> pg;

	AHP();
	AHP(const AHP &);
	AHP(AHP *);
	virtual ~AHP();

	void Conception();
	void Acquisition(int);
	void Synthesis();
	void Consistency();
private:
	std::vector<double> CalculatePG(Node *);
};
