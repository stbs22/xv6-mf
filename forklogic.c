#include <unistd.h>
#include <stdio.h>

//fork propio de unistd.h
//como se divide el stdout

int main(void){
  int valor = 0;
  valor++;
  printf("Pid prefork: %d - %d\n", getpid(), valor); 
  
  int proceso_hijo = fork();
  
  if(proceso_hijo != 0) valor++;
  
  printf("[%d - %p] pid del hijo: %d - pid del padre: %d\n",valor, &valor, proceso_hijo,getpid());
  
  return 0;
}
