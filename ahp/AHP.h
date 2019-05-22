#pragma once

#include <assert.h>
#include <iostream>
#include <unistd.h>
#include <fstream>
#include <sstream>
#include <cstdlib>
#include <cmath>
#include <vector>
#include "Tree.h"
#include <regex>

class AHP {
public:
Tree *hierarchy;
std::vector<double> pg;

AHP();
AHP(const AHP &);
AHP(AHP *);
virtual ~AHP();

void Conception(int);
void Acquisition(int);
void Synthesis(int);
void Consistency();

private:
std::vector<double> CalculatePG(Node *);
};
