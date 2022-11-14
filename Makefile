#Cambiar por nombre de archivo .c
###########################
NAME = clase8
###########################

CC = gcc
CODE = $(NAME).c
OBJ = $(NAME).o
EXE = $(NAME)

all: $(CODE)
	$(CC) $(CODE) -o $(EXE)
	
	./$(EXE)

$(OBJ): $(CODE)
	$(CC) -c $(CODE)

clean:
	rm -f *.o $(EXE) *~
