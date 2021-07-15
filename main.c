#include <HsFFI.h>
#include <stdio.h>

#include "asdf_stub.h"

int main() {
	hs_init(0, NULL);

	printf("%d\n", asdf(3));

	return 0;
}
