#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]){
  printf("location of text : %p\n", (void*) main);
  
  static int sttc = 2;
  
  printf("location of data : %p\n", (void*) &sttc);
  printf("location of heap : %p\n", (void*) malloc(1));
  
  int x = 3;
  
  printf("location of stack : %p\n", (void*) &x);
  
  return EXIT_SUCCESS;
}
