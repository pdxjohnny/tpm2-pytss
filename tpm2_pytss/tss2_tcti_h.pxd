from libc.stdint cimport (
    int8_t,
    uint8_t,
    int16_t,
    uint16_t,
    int32_t,
    uint32_t,
    int64_t,
    uint64_t,
)

from tss2_common_h cimport (
    TSS2_RC,
)

from tss2_tpm2_types_h cimport (
    TPM2_HANDLE,
)


cdef extern from "<tss2/tss2_tcti.h>":
    ctypedef pollfd pollfd

    struct TSS2_TCTI_CONTEXT:
        pass

    typedef TSS2_RC (*TSS2_TCTI_TRANSMIT_FCN)(TSS2_TCTI_CONTEXT *tctiContext, size_t size, const uint8_t *command)

    typedef TSS2_RC (*TSS2_TCTI_RECEIVE_FCN)(TSS2_TCTI_CONTEXT *tctiContext, size_t *size, uint8_t *response, int32_t timeout)

    typedef void (*TSS2_TCTI_FINALIZE_FCN)(TSS2_TCTI_CONTEXT *tctiContext)

    typedef TSS2_RC (*TSS2_TCTI_CANCEL_FCN)(TSS2_TCTI_CONTEXT *tctiContext)

    typedef TSS2_RC (*TSS2_TCTI_GET_POLL_HANDLES_FCN)(TSS2_TCTI_CONTEXT *tctiContext, TSS2_TCTI_POLL_HANDLE *handles, size_t *num_handles)

    typedef TSS2_RC (*TSS2_TCTI_SET_LOCALITY_FCN)(TSS2_TCTI_CONTEXT *tctiContext, uint8_t locality)

    typedef TSS2_RC (*TSS2_TCTI_MAKE_STICKY_FCN)(TSS2_TCTI_CONTEXT *tctiContext, TPM2_HANDLE *handle, uint8_t sticky)

    typedef TSS2_RC (*TSS2_TCTI_INIT_FUNC)(TSS2_TCTI_CONTEXT *tctiContext, size_t *size, const char *config)

    struct TSS2_TCTI_CONTEXT_COMMON_V1:
        uint64_t magic
        uint32_t version
        TSS2_TCTI_TRANSMIT_FCN transmit
        TSS2_TCTI_RECEIVE_FCN receive
        TSS2_TCTI_FINALIZE_FCN finalize
        TSS2_TCTI_CANCEL_FCN cancel
        TSS2_TCTI_GET_POLL_HANDLES_FCN getPollHandles
        TSS2_TCTI_SET_LOCALITY_FCN setLocality

    struct TSS2_TCTI_CONTEXT_COMMON_V2:
        TSS2_TCTI_CONTEXT_COMMON_V1 v1
        TSS2_TCTI_MAKE_STICKY_FCN makeSticky

    ctypedef TSS2_TCTI_CONTEXT_COMMON_V2 TSS2_TCTI_CONTEXT_COMMON_CURRENT

    struct TSS2_TCTI_INFO:
        uint32_t version
        char name
        char description
        char config_help
        TSS2_TCTI_INIT_FUNC init

    typedef const TSS2_TCTI_INFO *(*TSS2_TCTI_INFO_FUNC)(void)

