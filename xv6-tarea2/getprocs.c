/*

Tarea 1 Sistemas Operativos TICS312 Sección 01
Alumno: Esteban Hernández

Crear llamada de CPU que devuelva la cantidad de procesos corriendo en el sistema

*/

#include "types.h"
#include "stat.h"
#include "user.h"

int main(void) {

  printf(1,"La cantidad de procesos corrindo en el sistema son %d\n",getprocs());

  exit();

}
