#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

#define MAX 50

/* PARTE 1 */

sem_t semaforo;
void* child(void* arg) {
  printf("child\n");

  sem_post(&semaforo);

  return NULL;
}

/* PARTE 2 */

int buffer[MAX];

int fill = 0;
int use = 0;
int count = 0;

pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

void put(int value) {
    buffer[fill] = value;
    fill = (fill + 1) % MAX;
    count++;
}

int get() {
    int tmp = buffer[use];
    use = (use + 1) % MAX;
    count--;
    return tmp;
}

void *producer(void *arg) {
    int i;
    int loop = (int)arg;
    for (i = 0; i < loop; i++) {
        pthread_mutex_lock(&lock);
        if(count >= MAX) pthread_cond_wait(&cond, &lock);
        put(i); 
        printf("buffer i:%i - count:%i\n", i, count);
        pthread_cond_signal(&cond);
        pthread_mutex_unlock(&lock);
    }   
}

void consumer() {
    int i;
    int loop = (int)arg;
    for (i = 0; i < loop; i++) {
        pthread_mutex_lock(&lock);
        if(count == 0) pthread_cond_wait(&cond, &lock);
        int tmp = get();
        printf("buffer i:%i - count:%i", i, count);
        pthread_cond_signal(&cond);
        pthread_mutex_unlock(&lock);
    }


int main(void) {
    
    //PARTE 1//

    sem_init(&semaforo, 0, 0); // 1 cuando son 2 hebras, 0 cuando es 1 hebra
    
    printf("inicio de la hebra\n");
    
    pthread_t hebraHijoP1;
    pthread_create(&hebraHijoP1, NULL, child, NULL);
    sem_wait(&semaforo); // bloquea la hebra hasta que el semaforo sea 1
    
    printf("fin de la hebra\n");

    //PARTE 2//



    return 0;
}