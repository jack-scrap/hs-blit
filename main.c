#include <HsFFI.h>
#ifdef __GLASGOW_HASKELL__
#include "asdf_stub.h"
#endif
#include <stdio.h>

int main() {
	hs_init(0, NULL);

	printf("Fibonacci: %d\n", fibonacci_hs(42));

	hs_exit();
	return 0;
}
