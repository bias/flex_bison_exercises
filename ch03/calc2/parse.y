/* calculator using AST with operator precedence */

%{
#include <stdio.h>
#include <stdlib.h>
#include "calc.h"
%}

%union {
  struct ast *a;
  double d;
}

/* declare tokens */
%token <d> NUMBER
%token EOL

/* precedence and associativity */
%left '+' '-'
%left '*' '/'
%nonassoc '|' LMINUS

%type <a> exp

%%

calclist: /* nothing */
  | calclist exp EOL { printf("%4.4g\n", eval($2)); treefree($2); printf("> "); }
  | calclist EOL { printf("> "); }
  ;

exp: exp '+' exp  { $$ = newast('+', $1, $3); }
  | exp '-' exp   { $$ = newast('-', $1, $3); }
  | exp '*' exp   { $$ = newast('*', $1, $3); }
  | exp '/' exp   { $$ = newast('/', $1, $3); }
  | '|' exp       { $$ = newast('|', $2, NULL); }
  | '(' exp ')'   { $$ = $2; }
  | '-' exp %prec LMINUS { $$ = newast('M', $2, NULL); }
  | NUMBER        { $$ = newnum($1); }
  ;

%%
