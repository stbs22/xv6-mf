#include <stdlib.h>
#include <stdio.h>

#include <pthread.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/syscall.h>

typedef struct node{
    int data;
    struct node* next;
} node;

void print_list(node* head)
{
    node* cursor = head;
    while(cursor != NULL)
    {
        printf("%d ", cursor->data);
        cursor = cursor->next;
    }
}

node* create(int data,node* next)
{
    node* new_node = (node*)malloc(sizeof(node));
    if(new_node == NULL)
    {
        printf("Error creating a new node.\n");
        exit(0);
    }
    new_node->data = data;
    new_node->next = next;
 
    return new_node;
}

node* append(node* head, int data)
{
    /* go to the last node */
    node *cursor = head;
    while(cursor->next != NULL)
        cursor = cursor->next;
 
    /* create a new node */
    node* new_node =  create(data,NULL);
    cursor->next = new_node;
 
    return head;
}

node* remove_front(node* head)
{
    if(head == NULL)
        return NULL;
    node *front = head;
    head = head->next;
    front->next = NULL;
    /* is this the last node in the list */
    if(front == head)
        head = NULL;
    free(front);
    return head;
}

node* remove_back(node* head)
{
    if(head == NULL)
        return NULL;
 
    node *cursor = head;
    node *back = NULL;
    while(cursor->next != NULL)
    {
        back = cursor;
        cursor = cursor->next;
    }
    if(back != NULL)
        back->next = NULL;
 
    /* if this is the last node in the list*/
    if(cursor == head)
        head = NULL;
 
    free(cursor);
 
    return head;
}

pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void *hilo_funcion(void *cabecera){
  
  pid_t tid = syscall(SYS_gettid);

  pthread_mutex_lock(&lock);

  node* current = (node*)cabecera;

  current->data++;
  current = append( current, current->data);

  pthread_mutex_unlock(&lock);

  printf("Hilo %d, data %d\n",tid,current->data);
  return NULL;
}

int main(void) {
  

  /*  SECUENCIAL  */
  
  node* cadena_secuencial = NULL;  
  cadena_secuencial = create(0, NULL);

  for(int i = 1; i < 100; i++){
    cadena_secuencial = append(cadena_secuencial, i);
  }  


  /*  PARALELO  */

  node* cadena_paralela;
  cadena_paralela = create(0, NULL);

  if( pthread_mutex_init(&lock, NULL) != 0 ){

    printf("Error al crear el mutex\n");
    
    return 1;
  
  }

  for(int i = 0; i < 100; i++){
    pthread_t hilo;
    
    pthread_create(&hilo, NULL, &hilo_funcion, cadena_paralela);
    pthread_join(hilo, NULL);

    printf("Pasa que en %d tenemos :",i);
    print_list(cadena_paralela);
  }

  
  /*  MUESTREO  */

  printf("\nCadena secuencial: \n-->");
  print_list(cadena_secuencial);

  printf("\nCadena paralela: \n-->");
  print_list(cadena_paralela);

  printf("\nListo!\n");
  pthread_exit(NULL);
  return 0;
}