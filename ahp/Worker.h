#pragma once

class Worker{
public:
	Worker();
	Worker(const Worker &);
	Worker(Worker *);
	~Worker();
};

