# ***************************** # 
# ******Makefile : Calc******** #
# ***************************** # 
     
     
LEX     = flex
YACC    = bison -y 
YFLAGS  = -d
objects = calc.o lexer.o number.o

calc: $(objects)
	cp lexer.c lexer.c.bak
	cp calc.c calc.c.bak

calc.o: khash.h calc.h

lexer.o: calc.h

number.o: calc.h

.PHONY: clean

clean:
	rm -f *.o *.bak calc y.tab.h *.tab.*

