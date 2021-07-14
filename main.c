#include <HsFFI.h>
#ifdef __GLASGOW_HASKELL__
#include "asdf_stub.h"
#endif
#include <stdio.h>

int main() {
	int i;
	hs_init(0, NULL);

	i = fibonacci_hs(42);
	printf("Fibonacci: %d\n", i);

	hs_exit();
	return 0;
}
