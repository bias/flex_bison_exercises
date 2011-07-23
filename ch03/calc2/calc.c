#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "calc.h"

struct ast * newast(int nodetype, struct ast *l, struct ast *r) {
  struct ast *a; 

  if(!(a = malloc(sizeof(struct ast)))) {
    perror("newast/3");
    exit(0);
  }
  a->nodetype = nodetype;
  a->l = l;
  a->r = r;
  return a;
}

struct ast * newnum(double d) {
  struct numval *n;

  if(!(n = malloc(sizeof(struct numval)))) {
    perror("newnum/1");
    exit(0);
  }
  n->nodetype = 'K';
  n->number = d;
  return (struct ast *)n;
}

double eval(struct ast *a) {
  double v;

  switch(a->nodetype) {
	case 'K': v = ((struct numval *)a)->number; break;
    case '+': v = eval(a->l) + eval(a->r); break;
    case '-': v = eval(a->l) - eval(a->r); break;
    case '*': v = eval(a->l) * eval(a->r); break;
    case '/': v = eval(a->l) / eval(a->r); break;
    case '|': if ( (v = eval(a->l)) < 0 ) v=-v; break;
    case 'M': v = -eval(a->l); break;
    default: fprintf(stderr, "eval: internal error: bad node \'%c\'\n", a->nodetype);
  }
  return v;
}

void treefree(struct ast *a) {
  switch(a->nodetype) {
	  /* two subtrees, fall through to one also */
	  case '+':
	  case '-':
	  case '*':
	  case '/':
	  	treefree(a->r);
	  /* one subtree */
	  case '|':
	  case 'M':
	  	treefree(a->l);
	  /* no subtree */
	  case 'K':
	  	free(a); break;
	  /* catch errors */
	  default: fprintf(stderr, "treefree: internal error: free bad node \'%c\'\n", a->nodetype);
  }
}

void yyerror(char *s, ...) {
	va_list ap;
	va_start(ap, s);

	fprintf(stderr, "%d: error: ", yylineno);
	vfprintf(stderr, s, ap);
	fprintf(stderr, "\n");
}

int main() {
	printf("> ");
	return yyparse();
}
