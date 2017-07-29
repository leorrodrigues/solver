all:
	g++ main.cpp Method.cpp AHP.cpp Tree.cpp Solver.cpp Worker.cpp Buffer.cpp Interfaces.cpp GUI.cpp Web.cpp -o solver
	./solver
debug:
	g++ main.cpp Method.cpp AHP.cpp Tree.cpp Solver.cpp Worker.cpp Buffer.cpp Interfaces.cpp GUI.cpp Web.cpp -D DEBUG -o solver
	./solver
example:
	g++ main.cpp Method.cpp AHP.cpp Tree.cpp Solver.cpp Worker.cpp Buffer.cpp Interfaces.cpp GUI.cpp Web.cpp -D EXAMPLE -D DEBUG -o solver
	./solver
clear:
	rm solver
