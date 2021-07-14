HC=ghc

.PHONY: clean

all: hs c

hs: safe.hs
	$(HC) -c -O $<

c: main.c
	$(HC) --make -no-hs-main -optc-O $< safe -o main

clean:
	rm *.hi *.o main
