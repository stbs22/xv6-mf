#include <stdio.h>
#include <fcntl.h>

int main(void){
  
  int fd; 
  FILE *fp;

  mode_t modo = S_IRWXU;
  
  fd = open("pruebaqla.txt", O_WRONLY | O_CREAT | O_TRUNC, modo);
  
  if( fd < 0 ){
    printf("Ta mala la wea");
    return -1;
  }

 
  printf("file descriptor: %i",fd); 
  fp = fdopen(fd,"w");
  fprintf(fp,"wena ctm");
  fclose(fp);

  return 0;
}
