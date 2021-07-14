HC=ghc

.PHONY: clean

all: hs c

hs: Safe.hs
	$(HC) -c -O $<

c: test.c
	$(HC) --make -no-hs-main -optc-O $< Safe -o test

clean:
	rm *.hi *.o test
