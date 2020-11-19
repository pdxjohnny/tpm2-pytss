#
# Cython has many of the libc functions ready for import and use
#
from libc.stdio cimport printf
from libc.stdint cimport (uint8_t, uint16_t, uint32_t)

#
# Python is valid Cython, so we can just declare classes and things in here
#
class TSS2Exception(Exception):
    def __init__(self, rc):
        self.rc = rc
        self.message = "TSS2 Exception: {}".format(rc)

# Since we need to store a pointer, cdef the class
cdef class EsysContext(object):
    cdef ESYS_CONTEXT *__ectx

    def __init__(self):
        self.__ectx = wrap_Esys_Initialize()

    def rand(self, requestedBytes):
        cdef TPM2B_DIGEST *rand
        rand = wrap_Esys_Getrandom(self.__ectx, requestedBytes)
        return rand.digest

    def __del__(self):
        print("TODO IMPLEMENT DEL")

#
# Declaring C Types as Python types. The type doesn't matter much, just use the right
# general kind.
#
ctypedef uint32_t TSS2_RC
ctypedef uint32_t ESYS_TR
ctypedef uint16_t UINT16
ctypedef uint8_t UINT8
ctypedef uint8_t BYTE

cdef struct TPM2B_DIGEST:
    UINT16 size
    BYTE digest[1]

#
# If you need to define an unknown function you can do so like this
#
cdef extern from "<tss2/tss2_esys.h>":
    struct ESYS_CONTEXT:
        # Opaque's MUST be done from cdef extern blocks
        pass

    struct TSS2_TCTI_CONTEXT:
        # Opaque
        pass

    struct TSS2_ABI_VERSION:
        # Opaque
        pass
    
    # Native C Call
    TSS2_RC Esys_Initialize(
            ESYS_CONTEXT **ppEctxm,
            TSS2_TCTI_CONTEXT *pTctx,
            TSS2_ABI_VERSION *pAVersion)
    
    TSS2_RC Esys_GetRandom(
            ESYS_CONTEXT *ectx,
            ESYS_TR shandle1, ESYS_TR shandle2, ESYS_TR shandle3,
            UINT16 bytesRequested,
            TPM2B_DIGEST **randomBytes)

# Create the Cython wrapper
cdef ESYS_CONTEXT *wrap_Esys_Initialize():
    print("Calling Esys_Initialize")
    cdef ESYS_CONTEXT *x = NULL
    cdef TSS2_RC rc = 0
    printf("rc: %d ptr: %p\n", rc, x)
    rc = Esys_Initialize(&x, NULL, NULL)
    if rc != 0:
        raise TSS2Exception(rc)
    printf("rc: %d ptr: %p\n", rc, x)
    return x

cdef TPM2B_DIGEST *wrap_Esys_Getrandom(ESYS_CONTEXT *ectx, int requestedBytes):
    print("Calling getrandom: {}".format(requestedBytes))
    cdef TSS2_RC rc = 0
    cdef TPM2B_DIGEST *x = NULL
    ESYS_TR_NONE=0xfff
    printf("rc: %d ptr: %p\n", rc, x)
    rc = Esys_GetRandom(ectx, ESYS_TR_NONE, ESYS_TR_NONE, ESYS_TR_NONE, requestedBytes, &x)
    if rc != 0:
        raise TSS2Exception(rc)
    printf("BILL: rc: %d ptr: %p len: %u data[0]: %x data[4]: %x\n", rc, x, x.size, x.digest[0], x.digest[4])
    return x
