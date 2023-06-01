CC=gcc
HC=ghc

EXEC=hs_blit

LDFLAGS=-lSDL2 -lSDL2_image
HSFLAGS=-Wno-tabs

BUILDDIR=build

SRC=util.c err.c
OBJ=$(SRC:%.c=$(BUILDDIR)/%.o)

STUB=Shad_stub.h

ODIR=o

.PHONY: all
all: mk_build $(EXEC) mk_o

$(BUILDDIR)/%.o: %.c %.h
	$(CC) -c $< -o $@

%_stub.h: %.hs
	$(HC) $(HSFLAGS) -c -O $<

$(EXEC): main.c $(OBJ) $(STUB)
	$(HC) --make -no-hs-main -optc-O $< $(OBJ) Shad -o $@ $(LDFLAGS)

.PHONY: mk_build
mk_build:
	mkdir -p $(BUILDDIR)

.PHONY: mk_o
mk_o:
	mkdir -p $(ODIR)

.PHONY: clean
clean:
	rm *_stub.h *.hi $(BUILDDIR)/*.o $(EXEC)
