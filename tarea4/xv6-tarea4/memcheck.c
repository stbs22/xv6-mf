//#include <stdio.h>
#include "types.h"
#include "stat.h"
#include "user.h"
//#include "proc.h"
//#include "spinlock.h"
//#include "param.h"
/*
int memcheck(int num){
	return num*10;
}
*/

int main(int argc, char** argv){
	printf(1,"\nArgumentos: %d\n",argc);
	for(int i = 0; i < argc; i++) printf(1,"Valor: %s\nMemcheck: %d\n\n",argv[i],memcheck((int)argv[i]));
	return 0;
}
