/* Standard Includes */
#include <iostream>
#include <stdlib.h>
#include <locale.h>

/* Multicriteria Methods Includes */
#include "AHP.h"

/* Tree Includes */
#include "Tree.h"

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
