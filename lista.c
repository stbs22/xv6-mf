#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct lista {
 
 int data;
 struct lista* next;

}nodo;


int main(void){
  
  nodo* head = NULL;
  head = (nodo*)malloc(sizeof(nodo));

  nodo* hola1 = NULL;
  hola1 = (nodo*)malloc(sizeof(nodo));

  nodo* hola2 = NULL;
  hola2 = (nodo*)malloc(sizeof(nodo));
  
  head->next = hola1;
  
  hola1->data = 3;
  hola1->next = hola2;
  
  hola2->data = 10;
  hola2->next = NULL;
 
  return 0;
}
