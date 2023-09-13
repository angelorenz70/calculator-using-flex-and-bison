# Makefile using Flex/Bison to build a simple integer calculator

CC     = gcc
CFLAGS = -g -O

YACC   = bison
YFLAGS = -dv -bicalc

LEX    = flex
LFLAGS = -t

SRC    = icalc.y icalc.l
OBJ    = icalc.o scan.o

all:	icalc

icalc:	$(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@ -lm

scan.o:	icalc.c

scan.c: icalc.l
	$(LEX) $(LFLAGS) icalc.l > scan.c

icalc.c: icalc.y
	$(YACC) $(YFLAGS) icalc.y
	@mv icalc.tab.c icalc.c
	@mv icalc.tab.h icalc.h
	
clean:; @rm -f icalc icalc.output icalc.h icalc.c scan.c *.o
