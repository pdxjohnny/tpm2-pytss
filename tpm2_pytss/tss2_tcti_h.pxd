# Pulled from sys/poll.h for some reason Cython won't let us typedef
cdef struct TSS2_TCTI_POLL_HANDLE:
    int fd
    short int events
    short int revents


cdef extern from "<tss2/tss2_tcti.h>":
    struct TSS2_TCTI_CONTEXT:
        pass
