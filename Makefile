HC=ghc

EXEC=hs_blit

LDFLAGS=-lSDL2

.PHONY: all
all: stub $(EXEC)

.PHONY: stub
stub: shad.hs
	$(HC) -c -O $<

$(EXEC): main.c
	$(HC) --make -no-hs-main -optc-O -Wno-tabs $< shad -o $@ $(LDFLAGS)

.PHONY: clean
clean:
	rm *_stub.h *.hi *.o $(EXEC)
