HC=ghc

.PHONY: clean

all: stub make

stub: asdf.hs
	$(HC) -c -O $<

make: main.c
	$(HC) --make -no-hs-main -optc-O $< asdf -lSDL2

clean:
	rm *_stub.h *.hi *.o a.out
