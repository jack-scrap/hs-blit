HC=ghc

EXEC=hs_blit

LDFLAGS=-lSDL2 -lSDL2_image

ODIR=o

.PHONY: all
all: $(EXEC) mk_o

Shad_stub.h: Shad.hs
	$(HC) -Wno-tabs -c -O $<

$(EXEC): main.c Shad_stub.h
	$(HC) --make -no-hs-main -optc-O $< Shad -o $@ $(LDFLAGS)

.PHONY: mk_o
mk_o:
	mkdir -p $(ODIR)

.PHONY: clean
clean:
	rm *_stub.h *.hi *.o $(EXEC)
