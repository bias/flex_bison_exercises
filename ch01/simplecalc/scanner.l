/* recognize tokens for the calculator and print them out */
%{
#include "calc.tab.h"
extern int yylval;
%}

%%

"+" 	{ return ADD; }
"-" 	{ return SUB; }
"*" 	{ return MUL; }
"/" 	{ return DIV; }
"|" 	{ return ABS; }
[0-9]+	{ yylval = atoi(yytext); return NUMBER; }
\n		{ return EOL; }
[ \t]	{ /* ignore */ }
.		{ fprintf(stderr, "Mystery character %c\n", *yytext); }
