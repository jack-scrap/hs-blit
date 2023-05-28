#ifndef COL_H
#define COL_H

#define CHAN_NO 3

enum {
	R,
	G,
	B,
	A
} chan_t;

typedef struct {
	unsigned int _r;
	unsigned int _g;
	unsigned int _b;
} Col;

uint32_t rmask = 0x0000ff00;
uint32_t gmask = 0x00ff0000;
uint32_t bmask = 0xff000000;
uint32_t amask = 0x000000ff;

Col grey[2] = {
	{
		34,
		34,
		34
	}, {
		102,
		102,
		102
	}
};

Col purple[2] = {
	{
		69,
		59,
		87
	}, {
		97,
		82,
		134
	}
};

#endif
