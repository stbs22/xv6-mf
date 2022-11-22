#include "types.h"
#include "user.h"

int main(int argc, char** argv){
  
  if(argc != 2) { 
    printf(1,"\n**Error de Argumentos**\nptemap [VALOR HEXADECIMAL]\n\n"); 
    return 1; 
  }

  int va = atoi(argv[1]); 
  int phy = ptemap((uint*) va); 
  
  printf(1,"Indice direccion virtual: 0x%x\n",(uint)va);  

  if(phy != -1) 
    printf(1,"Tabla de Paginacion fisica: 0x%x\n", phy);
  else
    printf(1,"Tabla de Paginacion fisica inexistente\n");

  exit();
}
