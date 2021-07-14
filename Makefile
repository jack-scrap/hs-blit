HC=ghc

.PHONY: clean

all: hs c

hs: asdf.hs
	$(HC) -c -O $<

c: main.c
	$(HC) --make -no-hs-main -optc-O $< asdf -o main

clean:
	rm *_stub.h *.hi *.o main
