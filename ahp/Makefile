all:
	g++ main.cpp AHP.cpp Tree.cpp -o solver -O3
debug:
	g++ main.cpp AHP.cpp Tree.cpp -D DEBUG -o solver
example:
	g++ main.cpp AHP.cpp Tree.cpp -D EXAMPLE -D DEBUG -o solver
analise:
	g++ main.cpp AHP.cpp Tree.cpp -D ANALYSIS -o solver -O3 -pg
time:
	g++ main.cpp AHP.cpp Tree.cpp -D TIME -o solver
profile:
	g++ main.cpp AHP.cpp Tree.cpp -o solver -O3 -pg
clear:
	rm solver
