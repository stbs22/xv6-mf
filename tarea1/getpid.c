/*

Tarea 1 Sistemas Operativos TICS312 Sección 01
Alumno: Esteban Hernández

Crear programa que devuelva la cantidad de procesos corriendo en el sistema

*/


#include "types.h"
#include "stat.h"
#include "user.h"
#include "proc.h"
#include "spinlock.h"
#include "param.h"


struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

//devolver la canidad de procesos corriendo en el sistema
int getprocs(void){
  int n;
  n = 0;
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state != UNUSED)
      n++;
  }
  return n;
}

int main(void) {
  printf(1, "La cantidad de procesos en ejecucion en la CPU es %i \n",getprocs());
  return 0;
}
