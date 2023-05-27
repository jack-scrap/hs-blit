HC=ghc

EXEC=hs_blit

LDFLAGS=-lSDL2

.PHONY: all
all: stub $(EXEC)

.PHONY: stub
stub: asdf.hs
	$(HC) -c -O $<

$(EXEC): main.c
	$(HC) --make -no-hs-main -optc-O $< asdf -o $@ $(LDFLAGS)

.PHONY: clean
clean:
	rm *_stub.h *.hi *.o $(EXEC)
