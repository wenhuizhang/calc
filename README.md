calc
====
An interactive calculator using lex and yacc.



## 1. Description

An interactive calculator using lex and yacc, which:

  - The calculator accepts one expression at a time, evaluates the expression, and prints the result value in the next line. The input line starts with “->” and the result line starts with “=>”.

  - The input expression is represented in infix notation. An expression (expression) consists of variables (variable), expressions, numbers and ops.

  - A user can define variables. A declared variable is set to 0 if not initialized. A variable begins with a letter followed by any number of letters (lower-case).

  - Numbers (number) are represented in decimals using digit.

  - If an expression has syntax error, it simply prints “syntax error”, and waits for the next input.


## 2. Usage

```
Wenhuis-MacBook-Pro:calc wenhuizhang$ make
bison -y  -d calc.y 
mv -f y.tab.c calc.c
cc    -c -o calc.o calc.c
flex  -t lexer.l > lexer.c
cc    -c -o lexer.o lexer.c
cc    -c -o extcalc.o extcalc.c
cc -o calc calc.o lexer.o extcalc.o
rm lexer.c calc.c
Wenhuis-MacBook-Pro:calc wenhuizhang$ ./calc 
-> 1*2
=> 2
-> 
```

When using compare ("<=", ">=" etc.), it returns "0" for False, "1" for True. 
```
Wenhuis-MacBook-Pro:calc wenhuizhang$ ./calc 
-> 2 + 1
=> 3
-> (2+1)<=3 
=> 1
-> (2+1)==3        
=> 1
-> (2+1)!=3    
=> 0
-> ^C
```

## 3. License

All are Apache-2 license except for `khash.h`.

`khash.h` which is licensed under MIT license. 

Ref: http://attractivechaos.awardspace.com/khash.h.html
