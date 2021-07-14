#include <HsFFI.h>
#ifdef __GLASGOW_HASKELL__
#include "asdf_stub.h"
#endif
#include <stdio.h>

int main() {
	hs_init(0, NULL);

	printf("%d\n", asdf(3));

	return 0;
}
