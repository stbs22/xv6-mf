Tarea 2 hecha por: Esteban Eduardo Hernandez Salas
TICS312 Sección 1 Sistemas Operativos

** Se utiliza xv6 con cambios de la entrega anterior corregidos para conservar cambios **
** Basado en el contenido visto en clases y los ejemplos de la pagina https://github.com/avaiyang/xv6-lottery-scheduling **

En init.c:
	Linea 23: printf(1, "init: starting sh\n\n*****\nTAREA TICS312 Seccion 1\n Alumno:Esteban Hernandez\n*****\n\n");

En proc.h:

	Linea 16 a Linea 17:
	[
		extern struct cpu *cpu asm("%gs:0");
		extern struct proc *proc asm("%gs:4");
	]
	
	Linea 52: int tickets_amount	//Cantidad de tiquets asignados

En proc.c
	Linea 9: #include "rand.h"
	
	Linea 314 a Linea 326:
	[
		int lottery_Total(void){
		  struct proc *p;
		  int ticket_aggregate=0;

		  //loop over process table and increment total tickets if a runnable process is found 
		  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
		  {
			if(p->state==RUNNABLE){
			  ticket_aggregate+=p->tickets_amount;
			}
		  }
		  return ticket_aggregate;          //returning total number of tickets for runnable processes
		}
	]
	
	Linea 337 a Linea 396:
	[
		void
		scheduler(void)
		{
		  struct proc *p;
		  struct cpu *c = mycpu();
		  c->proc = 0;

|		  int foundproc = 1;
|		  int count = 0;
|		  long golden_ticket = 0;
|		  int total_no_tickets = 0;

		  for(;;){
			// Enable interrupts on this processor.
			sti();

|			if (!foundproc) hlt();
|			foundproc = 0;
			// Loop over process table looking for process to run.
			acquire(&ptable.lock);
			//resetting the variables to make scheduler start from the beginning of the process queue
|			golden_ticket = 0;
|			count = 0;
|			total_no_tickets = 0;
			
			//calculate Total number of tickets for runnable processes  
|			total_no_tickets = lottery_Total();

			//pick a random ticket from total available tickets
|			golden_ticket = random_at_most(total_no_tickets);
		 
			for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
			  if(p->state != RUNNABLE)
				continue;

			  //find the process which holds the lottery winning ticket 
|			  if ((count + p->tickets_amount) < golden_ticket){
|				count += p->tickets_amount;
|				continue;
|			  }

			  // Switch to chosen process.  It is the process's job
			  // to release ptable.lock and then reacquire it
			  // before jumping back to us.
|			  foundproc = 1;
|			  proc = p;
			  switchuvm(p);
			  p->state = RUNNING;
|			  swtch(&cpu->scheduler, proc->context);
			  switchkvm();

			  // Process is done running for now.
			  // It should have changed its p->state before coming back.
|			  proc = 0;
|			  break;
			}
			release(&ptable.lock);

		  }
		}
	]
	
	
	
	
	