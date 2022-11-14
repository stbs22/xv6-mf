//#include <stdio.h>
#include "types.h"
#include "stat.h"
#include "user.h"
//#include "proc.h"
//#include "spinlock.h"
//#include "param.h"
/*
void* memcheck(void* dir){
	return dir;
}
*/
int main(int argc, char** argv){
	printf(1,"\nArgumentos: %i\n",argc);
	for(int i = 0; i < argc; i++) printf(1,"Valor: %s\n",argv[i]);
	return 0;
}
