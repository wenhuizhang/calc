%{
  #include <stdlib.h>
  extern void yyerror(char *);

  #include "calc.h"
  #include "y.tab.h"
%}

%%

[a-zA-Z_][a-zA-Z_\d]*     {
                            yylval.string = strdup(yytext);
                            return VARIABLE;
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

[=]                      { return ASSIGN_OP;}

[ \t]                     ; // skip whitespace

.                         yyerror("invalid character");

%%

int yywrap(void) {
  return 1;
}
