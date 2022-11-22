Tarea 4 hecha por: Esteban Eduardo Hernandez Salas

Añadido archivo ptemap.c

En MakeFile:
  linea 177:  [ _ptemap\ ]
  linea 255:  [ ptemap.c\ ]

En syscall.h:
  linea 23: 	[ #define SYS_ptemap  22 ]

En sysproc.c:
  linea 94: 	[ int sys_ptemap (void) { return ptemap(); } ] 

En syscall.c:
  linea 106:  [ extern int sys_ptemap(void); ]
  linea 110:  [ [SYS_ptemap] sys_ptemap, ]

En usys.S:
  linea 32: 	[ SYSCALL(ptemap) ]

En defs.h:
  linea 26:  	[ int ptemap(int); ]

En user.h:
  linea 28: 	[ int ptemap(int); ]

En proc.c
  linea 536 a linea 548: 
  [
    int ptemap() {

    }
  ]
