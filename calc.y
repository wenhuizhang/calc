%{
  #include <stdio.h>
  #include <string.h>
  #include <unistd.h>

  #include "khash.h"
  #include "calc.h"

  #define BUFFER_SIZE 1024

  struct yy_buffer_state;
  typedef struct yy_buffer_state *YY_BUFFER_STATE;

  extern int yylex(void);
  extern YY_BUFFER_STATE yy_scan_string(const char *);
  extern void yy_delete_buffer(YY_BUFFER_STATE);

  void yyerror(char *);

  extern char* yytext;

  KHASH_MAP_INIT_STR(str, NUM);
  khash_t(str) *variables;
%}

%union {
  struct number num;
  char *string;
};

%token <num> INTEGER
%token <num> NUMBER
%token <string> VARIABLE
%token <string> ASSIGN_OP
%token <string> LETTER



%type <num> expr

%right ASSIGN_OP
%left '+' '-'
%left '*' '/'
%right '^'
%left UMINUS

%%

program:
        program expr '\n'      { PRINT_NUMBER($2); }
        |
        ;

expr:
        expr '+' expr             { $$ = ADD($1, $3); }
        | expr '-' expr             { $$ = SUBTRACT($1, $3); }
        | expr '*' expr             { $$ = MULTIPLY($1, $3); }
        | expr '/' expr             { $$ = DIVIDE($1, $3); }
        | expr '^' expr             { $$ = POW($1, $3); }
        | '-' expr %prec UMINUS     { $$ = NEGATE($2); }
        | VARIABLE ASSIGN_OP expr         { $$ = set_var($1, $3); }
        | '(' expr ')'              { $$ = $2; }
        | VARIABLE                  { $$ = get_var($1); }
        | INTEGER
        | NUMBER
        ;

%%

struct number get_var(char *name) {
  khiter_t k;

  k = kh_get(str, variables, name);

  // no var set. maybe we should throw an error?
  if (k == kh_end(variables)) return NEW_INTEGER(0);

  return kh_value(variables, k);
}

struct number set_var(char *name, struct number value) {
  khiter_t k;
  int ret;

  k = kh_put(str, variables, name, &ret);
  kh_value(variables, k) = value;

  return value;
}

void yyerror(char *s) {
  fprintf(stderr, "%s\n", s);
}

int main(int argc, const char *argv[]) {
  BOOL from_stdin = FALSE;

  if (argc > 1) {
    if (strcmp(argv[1], "-") == 0) {
      from_stdin = TRUE;
    } else {
      printf("ERROR: INPUT ERROR\n");
    //If an expression has syntax error, it simply prints “error”, and waits for the next input
    }
  } else if (!isatty(fileno(stdin))) {
    from_stdin = TRUE;
  }

  variables = kh_init(str);

  if (from_stdin) {
    yyparse();
  } else {
    char str[BUFFER_SIZE];
    YY_BUFFER_STATE buffer;

    while (TRUE) {
      printf("-> ");
      if (fgets(str, BUFFER_SIZE, stdin)) {
        printf("=> ");
        buffer = yy_scan_string(str);
        yyparse();
        yy_delete_buffer(buffer);
      }
    }
  }
  return 0;
}
