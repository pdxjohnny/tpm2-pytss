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

# Type definitions
ctypedef uint8_t     UINT8
ctypedef uint8_t     BYTE
ctypedef int8_t      INT8
ctypedef int         BOOL
ctypedef uint16_t    UINT16
ctypedef int16_t     INT16
ctypedef uint32_t    UINT32
ctypedef int32_t     INT32
ctypedef uint64_t    UINT64
ctypedef int64_t     INT64

# ABI runtime negotiation definitions
cdef struct TSS2_ABI_VERSION:
    uint32_t tssCreator
    uint32_t tssFamily
    uint32_t tssLevel
    uint32_t tssVersion

# Return Codes
# The return type for all TSS2 functions
ctypedef uint32_t TSS2_RC

# For return values other than SUCCESS, the second most significant
# byte of the return value is a layer code indicating the software
# layer that generated the error.
TSS2_RC_LAYER_SHIFT    = 16

cdef inline TSS2_RC TSS2_RC_LAYER(TSS2_RC level):
    return (level << TSS2_RC_LAYER_SHIFT)
