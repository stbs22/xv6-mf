#include "types.h"
#include "stat.h"
#include "user.h"
#include "mmu.h"

int main(void){
  printf(1,"\nEjecucion de syscall:\n");
  ptemap();
  printf(1,"\nFin de ejecucion\n");
  return 0;
}
