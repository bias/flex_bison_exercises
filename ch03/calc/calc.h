/*
 * Declarations for a calculator
 */

/* interface to the lexer */
extern int yylineno;
void yyerror(char *s, ...);

/* nodes in the abstract syntax tree */
struct ast {
  int nodetype;
  struct ast *l;
  struct ast *r;
};

struct numval {
  int nodetype; /* type k for constant */
  double number;
};

/* build and AST */
struct ast *newast(int nodetype, struct ast *l, struct ast *r);
struct ast *newnum(double d);

/* evaluate an AST */
double eval(struct ast *);

/* free an AST */
void treefree(struct ast *);
