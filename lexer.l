%{
  #include <stdlib.h>
  extern void yyerror(char *);

  #include "calc.h"
  #include "y.tab.h"
%}

%%

[a-z][a-z]*     {
                            yylval.string = strdup(yytext);
                            return VARIABLE; // varaible starts with a letter, follow by lower case letters
                          }

([1-9][0-9]+|[0-9])       {
                            yylval.num = NEW_INTEGER(strtol(yytext, NULL, 10));;
                            return INTEGER;
                          }
([1-9][0-9]+|[0-9])?\.[0-9]+ {

                               yylval.num = NEW_NUMBER(strtod(yytext, NULL));
                               return NUMBER;
                             }

[-+()/*\n^]              { return *yytext; }

"<="                     { return LESS_OR_EQUAL; }
"<"                      { return LESS_THAN; }
">="                     { return GREATER_OR_EQUAL; }
">"                      { return GREATER_THAN; }
"=="                     { return EQUALS; }
"!="                     { return NOT_EQUALS; }
"="                      { return ASSIGN_OP; }

[ \t]+                     ; // ignore space

.                         yyerror("invalid character");

%%

int yywrap(void) {
  return 1;
}
