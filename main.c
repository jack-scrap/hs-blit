#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
#include <stdbool.h>
#include <HsFFI.h>

#include "math.h"
#include "col.h"
#include "util.h"
#include "err.h"
#include "Shad_stub.h"

const unsigned int res[2] = {
	800,
	600
};

const char* oDir = "o";

const char sep = '/';

const char* f = "scr.png";

int t = 0;

int blitPix(unsigned char data[res[Y]][res[X]][CHAN_NO], Coord st, Col col) {
	if (data == NULL) {
		err(ERR_NULL_PTR);

		return 1;
	}

	if (!(st._x <= res[X] && st._y <= res[Y])) {
		err(ERR_PIXEL_COORD_BOUND);

		return 1;
	}

	data[st._y][st._x][R] = col._r;
	data[st._y][st._x][G] = col._g;
	data[st._y][st._x][B] = col._b;

	return 0;
}

int blitRect(unsigned char data[res[Y]][res[X]][CHAN_NO], Coord sz, Coord pos, Col col) {
	if (data == NULL) {
		err(ERR_NULL_PTR);

		return 1;
	}

	for (int y = 0; y < sz._y; y++) {
		for (int x = 0; x < sz._x; x++) {
			Coord st = {
				pos._x + x,
				pos._y + y
			};

			if (blitPix(data, st, col)) {
				err(ERR_BLIT_PIX);
			}
		}
	}

	return 0;
}

int blitShad(unsigned char data[res[Y]][res[X]][CHAN_NO], HsInt32 (*fn)(HsInt32)) {
	if (data == NULL) {
		err(ERR_NULL_PTR);

		return 1;
	}

	for (int y = 0; y < res[Y]; y++) {
		for (int x = 0; x < res[X]; x++) {
			Coord st = {
				x,
				y
			};

			Coord bound = {
				res[X],
				res[Y]
			};

			int i = coordToIdx(st, bound);

			if (fn(i)) {
				if (blitPix(data, st, purple[0])) {
					err(ERR_BLIT_PIX);
				}
			}
		}
	}

	return 0;
}

int clear(unsigned char data[res[Y]][res[X]][CHAN_NO]) {
	if (data == NULL) {
		err(ERR_NULL_PTR);

		return 1;
	}

	Coord origin = {
		0,
		0
	};

	Coord bound = {
		res[X],
		res[Y]
	};

	blitRect(data, bound, origin, grey[0]);

	return 0;
}

bool scrShot(char* filepath, SDL_Window* SDLWindow, SDL_Renderer* SDLRenderer) {
	SDL_Surface* saveSurface = NULL;
	SDL_Surface* infoSurface = SDL_GetWindowSurface(SDLWindow);

	if (infoSurface == NULL) {
		printf("%s%s\n", "Failed to create info surface from window in save(string), SDL_GetError() - ", SDL_GetError());
	} else {
		unsigned char pixels[infoSurface->w * infoSurface->h * infoSurface->format->BytesPerPixel];

		if (!pixels) {
			printf("Unable to allocate memory for screenshot pixel data buffer!\n");

			return false;
		} else {
			if (SDL_RenderReadPixels(SDLRenderer, &infoSurface->clip_rect, infoSurface->format->format, pixels, infoSurface->w * infoSurface->format->BytesPerPixel) != 0) {
				printf("%s%s\n", "Failed to read pixel data from SDL_Renderer object. SDL_GetError() - ", SDL_GetError());

				return false;
			} else {
				saveSurface = SDL_CreateRGBSurfaceFrom(pixels, infoSurface->w, infoSurface->h, infoSurface->format->BitsPerPixel, infoSurface->w * infoSurface->format->BytesPerPixel, infoSurface->format->Rmask, infoSurface->format->Gmask, infoSurface->format->Bmask, infoSurface->format->Amask);

				if (saveSurface == NULL) {
					printf("%s%s\n", "Couldn't create SDL_Surface from renderer pixel data. SDL_GetError() - ", SDL_GetError());

					return false;
				}

				IMG_SavePNG(saveSurface, filepath);
				SDL_FreeSurface(saveSurface);
				saveSurface = NULL;
			}
		}

		SDL_FreeSurface(infoSurface);
		infoSurface = NULL;
	}

	return true;
}

int main() {
	// Initialize
	hs_init(0, NULL);

	SDL_Window* win = SDL_CreateWindow("\\_", 0, 0, res[X], res[Y], 0);
	SDL_Renderer* rend = SDL_CreateRenderer(win, -1, SDL_RENDERER_SOFTWARE);

	SDL_Texture* tex = SDL_CreateTexture(rend, SDL_PIXELFORMAT_RGB24, SDL_TEXTUREACCESS_TARGET, res[X], res[Y]);

	unsigned char data[res[Y]][res[X]][CHAN_NO];

	char oPath[1 + 1 + 7 + 1];
	sprintf(oPath, "%s%c%s", oDir, sep, f);

	// Clear
	clear(data);

	SDL_Surface* surf = SDL_CreateRGBSurfaceFrom(data, res[X], res[Y], (CHAN_NO) * 8, (CHAN_NO) * res[X], rmask, gmask, bmask, amask);

	const SDL_Rect rect = {
		0,
		0,
		res[X],
		res[Y]
	};

	// Draw
	bool open = true;
	SDL_Event e;
	while (open) {
		while (SDL_PollEvent(&e)) {
			if (e.type == SDL_QUIT) {
				open = false;
			}

			if (e.type == SDL_KEYDOWN) {
				if (e.key.keysym.sym == SDLK_F12) {
					scrShot(oPath, win, rend);
				}
			}
		}

		blitShad(data, solid);

		SDL_UpdateTexture(tex, &rect, surf->pixels, surf->pitch);

		SDL_RenderDrawRect(rend, &rect);

		SDL_RenderCopy(rend, tex, NULL, NULL);
		SDL_RenderPresent(rend);

		t++;
	}

	return 0;
}
