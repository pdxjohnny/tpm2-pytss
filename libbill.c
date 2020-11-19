#include <stdlib.h>
#include <stdio.h>

typedef int (*pfn)(void *userdata);
typedef struct BILL BILL;
struct BILL {
	void *udata;
	pfn callback;
};

void *bill_new(void) {
	return calloc(1, sizeof(BILL));
}

void bill_set_callback(BILL *b, pfn callback, void *udata) {
	b->udata = udata;
	b->callback = callback;
}

int bill_invoke_callback(BILL *b) {
	int rc = b->callback(b->udata);
	printf("Bill CB handler returned: %d\n", rc);
	return rc;
}

