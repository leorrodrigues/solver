/* Standard Includes */
#include <iostream>
#include <stdlib.h>
#include <locale.h>

/* Logic Includes */
#include "Worker.h"
#include "Buffer.h"
#include "Solver.h"

/* Interface Includes */
#include "Interfaces.h"
#include "GUI.h"
#include "Web.h"

/* Multicriteria Methods Includes */
#include "Method.h"
#include "AHP.h"

/* Tree Includes */
#include "Tree.h"

Interfaces *ptrInterface;
Worker *ptrWorker;
Method *ptrMethod;

int main(){
	setlocale(LC_ALL, "");
	//ptrInterface = new Interfaces();
	//ptrWorker = new Worker();
	//ptrMethod = new Method();

	AHP	*ptrAHP = new AHP();

	ptrAHP->Conception();
	ptrAHP->hierarchy->printTree();

	ptrAHP->Acquisition(2);

	ptrAHP->Synthesis();

	ptrAHP->Consistency();

	std::cout<<"Exiting...\n";
	return 0;
}
