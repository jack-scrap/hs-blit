CC=gcc
HC=ghc

EXEC=hs_blit

BUILDDIR=build

ODIR=o

LDFLAGS=-lSDL2 -lSDL2_image
HFLAGS=-Wno-tabs

SRC=util.c err.c
OBJ=$(SRC:%.c=$(BUILDDIR)/%.o)

HSRC=Shad.hs
STUB=$(HSRC:%.hs=%_stub.h)

.PHONY: all
all: mk_build $(EXEC) mk_o

$(BUILDDIR)/%.o: %.c %.h
	$(CC) -c $< -o $@

%_stub.h: %.hs
	$(HC) $(HFLAGS) -c -O $<

$(EXEC): main.c $(OBJ) $(STUB)
	$(HC) --make -no-hs-main -optc-O $< $(OBJ) $(HSRC:%.hs=%) -o $@ $(LDFLAGS)

.PHONY: mk_build
mk_build:
	mkdir -p $(BUILDDIR)

.PHONY: mk_o
mk_o:
	mkdir -p $(ODIR)

.PHONY: clean
clean:
	rm *_stub.h *.hi *.o $(BUILDDIR)/*.o $(EXEC)
