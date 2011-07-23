/* even more like Unix wc */
%option noyywrap
%{
int chars = 0;
int words = 0;
int lines = 0;

int totchars = 0;
int totwords = 0;
int totlines = 0;
%}

%%

[^ \t\n\r\f\v]+	{ words++; chars += strlen(yytext); }
\n				{ chars++; lines++; }
.				{ chars++; }

%%

main(int argc, char **argv) {
	int i;
	FILE *f;

	if (argc < 2) {
		yylex();
		printf("%8d%8d%8d\n", lines, words, chars);
		return 0;
	}

	for (i=1; i<argc; i++) {
		if(!(f = fopen(argv[i], "r"))) {
			perror(argv[i]);
			return 1;
		}
		yyrestart(f);
		yylex();
		fclose(f);
		printf("%8d%8d%8d %s\n", lines, words, chars, argv[i]);
		totchars += chars; chars = 0;
		totwords += words; words = 0;
		totlines += lines; lines = 0;
	}
	if (argc > 1) /* print total if more than one file */
		printf("%8d%8d%8d total\n", totlines, totwords, totchars);
	return 0;
}
