all:
	g++ main.cpp AHP.cpp Tree.cpp -o solver
	./solver
debug:
	g++ main.cpp AHP.cpp Tree.cpp -D DEBUG -o solver
	./solver
example:
	g++ main.cpp AHP.cpp Tree.cpp -D EXAMPLE -D DEBUG -o solver
	./solver
clear:
	rm solver
