Tarea 4 hecha por: Esteban Eduardo Hernandez Salas

Añadido archivo ptemap.c

En MakeFile:
  linea 177:  [ _ptemap\ ]
  linea 255:  [ ptemap.c\ ]

En init.c:
	Linea 24:	[ printf(1, "\nTarea 4 Sistemas Operativos 2022/2 \nSeccion 1\nAutor: Esteban Hernandez\n\n"); ]

En syscall.h:
  linea 23: 	[ #define SYS_ptemap  22 ]

En sysproc.c:
	Se configuran las entradas de syscall para recibir unasigned int y restringir el almacenamiento de las variables a 32 bits

  linea 93 a linea 97: 	
	[ 
		int sys_ptemap (uint *argv) {

			int i_s = (uint) argv;
			argint(0, &i_s);

			return ptemap(i_s); 
		} 
	] 

En syscall.c:
  linea 106:  [ extern int sys_ptemap(void); ]
  linea 110:  [ [SYS_ptemap] sys_ptemap, ]

En usys.S:
  linea 32: 	[ SYSCALL(ptemap) ]

En defs.h:
  linea 14:  	[ int ptemap(uint); ]

En user.h:
  linea 26: 	[ int ptemap(uint*); ]

En vm.c:
  En esta sección se realizan llamados a variables previamente definidas en mmu.h, que indican especificamente todos los valores necesarios para realizar la traducción, además de incluir funciones capaces de editar la composición de cada variable de dirección

	linea 387 a linea 405: 
  [
    int ptemap(uint virt_addr) {
				
				struct proc *p = myproc();
				char *fm;
  
				pde_t *pgdir, *pde, *pte, *pgtab;
				pgdir = p->pgdir;
				pde = &pgdir[PDX(virt_addr)];

				if ((*pde & PTE_P) && (*pde & PTE_U)) {

					pgtab = (pte_t*) P2V(PTE_ADDR(*pde));
					pte = &pgtab[PTX(virt_addr)];
					fm = (char*) PTE_ADDR(*pte);

				} else return -1;

				return (uint)fm;
    }
  ]

