#include <HsFFI.h>
#ifdef __GLASGOW_HASKELL__
#include "asdf_stub.h"
#endif
#include <stdio.h>

int main() {
	hs_init(0, NULL);

	printf("Fibonacci: %d\n", asdf_hs(42));

	return 0;
}
