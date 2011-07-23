LEX = flex
YACC = bison
YFLAGS = -d

objects = scan.o parse.o calc.o

calc: $(objects)

scan.o: scan.l parse.h calc.h

parse.o: parse.y calc.h

clean:
	rm -f calc parse.h $(objects) 

%.h: %.y
	$(YACC) $(YFLAGS) $< 
	mv -f $(basename $<).tab.c $(basename $<).c
	mv -f $(basename $<).tab.h $(basename $<).h
