HC=ghc

.PHONY: all
all: stub make

.PHONY: stub
stub: asdf.hs
	$(HC) -c -O $<

.PHONY: make
make: main.c
	$(HC) --make -no-hs-main -optc-O $< asdf -lSDL2

.PHONY: clean
clean:
	rm *_stub.h *.hi *.o a.out
