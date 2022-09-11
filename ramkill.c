#include <stdio.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <strings.h>

void generation(){
  
  int padre = fork();
  
  if (padre == 0){
    printf("padre %d\n",getpid());
    generation();
  }
  else{
    printf("hijo %d\n",getpid());
    for(;;){ float x = 0.00000000001; };
  }

}

int main(void){
  
  generation();

  return 0; 
}
