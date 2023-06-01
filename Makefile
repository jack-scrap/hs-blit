CC=gcc
HC=ghc

EXEC=hs_blit

LDFLAGS=-lSDL2 -lSDL2_image

SRC=util.c err.c
OBJ=$(SRC:%.c=%.o)

STUB=Shad_stub.h

ODIR=o

.PHONY: all
all: $(EXEC) mk_o

%.o: %.c %.h
	$(CC) -c $< -o $@

%_stub.h: %.hs
	$(HC) -Wno-tabs -c -O $<

$(EXEC): main.c $(OBJ) $(STUB)
	$(HC) --make -no-hs-main -optc-O $< $(OBJ) Shad -o $@ $(LDFLAGS)

.PHONY: mk_o
mk_o:
	mkdir -p $(ODIR)

.PHONY: clean
clean:
	rm *_stub.h *.hi *.o $(EXEC)
