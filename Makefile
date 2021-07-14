HC=ghc

.PHONY: clean

all: hs c

hs: safe.hs
	$(HC) -c -O $<

c: test.c
	$(HC) --make -no-hs-main -optc-O $< safe -o test

clean:
	rm *.hi *.o test
