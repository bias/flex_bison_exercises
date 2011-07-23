calc: scanner.l calc.y
	bison -d calc.y
	flex scanner.l
	gcc -o $@ calc.tab.c lex.yy.c -lfl
