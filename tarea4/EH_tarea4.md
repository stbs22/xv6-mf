Tarea 4 hecha por: Esteban Eduardo Hernandez Salas

**Kernel de XV6 Compilado con i386-elf-gcc en unix**

Utilizando el video compartido en el discord de la sección para la creacion de una llamada de sistema https://youtu.be/21SVYiKhcwM , se realizaron los siguientes Cambios a XV6:

Añadido archivo getpid.c

En MakeFile:
  linea 188:  [ _getprocs\ ]
  linea 258:  [ getprocs.c\ ]

En syscall.h:
  linea 25: [ #define SYS_getprocs  22 ]

En defs.h:
  linea 125:  [ int getprocs(void); ]

En user.h:
  linea 28: [ int getprocs(void); ]

En sysproc.c:
  linea 94: [ int sys_getprocs (void) { return getprocs(); } ] 

En usys.S:
  linea 32: [ SYSCALL(getprocs) ]
 
En syscall.c:
  linea 107:  [ extern int sys_getprocs(void); ]
  linea 132:  [ [SYS_getprocs] sys_getprocs, ]

En proc.c
  linea 536 a linea 548: 
  [
    int getprocs() {

      struct proc *p;
      int n_procs = 0;

      acquire(&ptable.lock);
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) if(p->state != UNUSED) n_procs++;
      release(&ptable.lock);
 
      return n_procs;
    }
  ]
