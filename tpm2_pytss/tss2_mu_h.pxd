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
    BYTE,
    INT16,
    INT32,
    INT64,
    INT8,
    TSS2_RC,
    UINT16,
    UINT32,
    UINT64,
    UINT8,
)

from tss2_tpm2_types_h cimport (
    TPM2B_ATTEST,
    TPM2B_AUTH,
    TPM2B_CONTEXT_DATA,
    TPM2B_CONTEXT_SENSITIVE,
    TPM2B_CREATION_DATA,
    TPM2B_DATA,
    TPM2B_DIGEST,
    TPM2B_ECC_PARAMETER,
    TPM2B_ECC_POINT,
    TPM2B_ENCRYPTED_SECRET,
    TPM2B_EVENT,
    TPM2B_ID_OBJECT,
    TPM2B_IV,
    TPM2B_MAX_BUFFER,
    TPM2B_MAX_NV_BUFFER,
    TPM2B_NAME,
    TPM2B_NONCE,
    TPM2B_NV_PUBLIC,
    TPM2B_OPERAND,
    TPM2B_PRIVATE,
    TPM2B_PRIVATE_KEY_RSA,
    TPM2B_PUBLIC,
    TPM2B_PUBLIC_KEY_RSA,
    TPM2B_SENSITIVE,
    TPM2B_SENSITIVE_CREATE,
    TPM2B_SENSITIVE_DATA,
    TPM2B_SYM_KEY,
    TPM2B_TEMPLATE,
    TPM2B_TIMEOUT,
    TPM2_CC,
    TPM2_HANDLE,
    TPM2_NT,
    TPM2_SE,
    TPM2_ST,
    TPMA_ALGORITHM,
    TPMA_CC,
    TPMA_LOCALITY,
    TPMA_NV,
    TPMA_OBJECT,
    TPMA_PERMANENT,
    TPMA_SESSION,
    TPMA_STARTUP_CLEAR,
    TPMI_ALG_HASH,
    TPML_AC_CAPABILITIES,
    TPML_ALG,
    TPML_ALG_PROPERTY,
    TPML_CC,
    TPML_CCA,
    TPML_DIGEST,
    TPML_DIGEST_VALUES,
    TPML_ECC_CURVE,
    TPML_HANDLE,
    TPML_INTEL_PTT_PROPERTY,
    TPML_PCR_SELECTION,
    TPML_TAGGED_PCR_PROPERTY,
    TPML_TAGGED_TPM_PROPERTY,
    TPMS_AC_OUTPUT,
    TPMS_ALGORITHM_DESCRIPTION,
    TPMS_ALGORITHM_DETAIL_ECC,
    TPMS_ALG_PROPERTY,
    TPMS_ATTEST,
    TPMS_AUTH_COMMAND,
    TPMS_AUTH_RESPONSE,
    TPMS_CAPABILITY_DATA,
    TPMS_CERTIFY_INFO,
    TPMS_CLOCK_INFO,
    TPMS_COMMAND_AUDIT_INFO,
    TPMS_CONTEXT,
    TPMS_CONTEXT_DATA,
    TPMS_CREATION_DATA,
    TPMS_CREATION_INFO,
    TPMS_ECC_PARMS,
    TPMS_ECC_POINT,
    TPMS_EMPTY,
    TPMS_ID_OBJECT,
    TPMS_KEYEDHASH_PARMS,
    TPMS_NV_CERTIFY_INFO,
    TPMS_NV_PIN_COUNTER_PARAMETERS,
    TPMS_NV_PUBLIC,
    TPMS_PCR_SELECT,
    TPMS_PCR_SELECTION,
    TPMS_QUOTE_INFO,
    TPMS_RSA_PARMS,
    TPMS_SCHEME_ECDAA,
    TPMS_SCHEME_HASH,
    TPMS_SCHEME_XOR,
    TPMS_SENSITIVE_CREATE,
    TPMS_SESSION_AUDIT_INFO,
    TPMS_SIGNATURE_ECC,
    TPMS_SIGNATURE_RSA,
    TPMS_SYMCIPHER_PARMS,
    TPMS_TAGGED_PCR_SELECT,
    TPMS_TAGGED_POLICY,
    TPMS_TAGGED_PROPERTY,
    TPMS_TIME_ATTEST_INFO,
    TPMS_TIME_INFO,
    TPMT_ASYM_SCHEME,
    TPMT_ECC_SCHEME,
    TPMT_HA,
    TPMT_KDF_SCHEME,
    TPMT_KEYEDHASH_SCHEME,
    TPMT_PUBLIC,
    TPMT_PUBLIC_PARMS,
    TPMT_RSA_DECRYPT,
    TPMT_RSA_SCHEME,
    TPMT_SENSITIVE,
    TPMT_SIGNATURE,
    TPMT_SIG_SCHEME,
    TPMT_SYM_DEF,
    TPMT_SYM_DEF_OBJECT,
    TPMT_TK_AUTH,
    TPMT_TK_CREATION,
    TPMT_TK_HASHCHECK,
    TPMT_TK_VERIFIED,
    TPMU_ASYM_SCHEME,
    TPMU_ATTEST,
    TPMU_CAPABILITIES,
    TPMU_ENCRYPTED_SECRET,
    TPMU_HA,
    TPMU_KDF_SCHEME,
    TPMU_NAME,
    TPMU_PUBLIC_ID,
    TPMU_PUBLIC_PARMS,
    TPMU_SCHEME_KEYEDHASH,
    TPMU_SENSITIVE_COMPOSITE,
    TPMU_SIGNATURE,
    TPMU_SIG_SCHEME,
    TPMU_SYM_KEY_BITS,
    TPMU_SYM_MODE,
)


cdef extern from "<tss2/tss2_mu.h>":
    TSS2_RC Tss2_MU_BYTE_Marshal(BYTE in, uint8_t *buffer, size_t size, size_t *offset)

    TSS2_RC Tss2_MU_BYTE_Unmarshal(const uint8_t buffer[], size_t size, size_t *offset, BYTE *out)

    TSS2_RC Tss2_MU_INT8_Marshal(INT8 src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_INT8_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, INT8 *dest)

    TSS2_RC Tss2_MU_INT16_Marshal(INT16 src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_INT16_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, INT16 *dest)

    TSS2_RC Tss2_MU_INT32_Marshal(INT32 src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_INT32_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, INT32 *dest)

    TSS2_RC Tss2_MU_INT64_Marshal(INT64 src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_INT64_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, INT64 *dest)

    TSS2_RC Tss2_MU_UINT8_Marshal(UINT8 src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_UINT8_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, UINT8 *dest)

    TSS2_RC Tss2_MU_UINT16_Marshal(UINT16 src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_UINT16_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, UINT16 *dest)

    TSS2_RC Tss2_MU_UINT32_Marshal(UINT32 src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_UINT32_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, UINT32 *dest)

    TSS2_RC Tss2_MU_UINT64_Marshal(UINT64 src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_UINT64_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, UINT64 *dest)

    TSS2_RC Tss2_MU_TPM2_CC_Marshal(TPM2_CC src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2_CC_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2_CC *dest)

    TSS2_RC Tss2_MU_TPM2_ST_Marshal(TPM2_ST src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2_ST_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2_ST *dest)

    TSS2_RC Tss2_MU_TPMA_ALGORITHM_Marshal(TPMA_ALGORITHM src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMA_ALGORITHM_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMA_ALGORITHM *dest)

    TSS2_RC Tss2_MU_TPMA_CC_Marshal(TPMA_CC src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMA_CC_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMA_CC *dest)

    TSS2_RC Tss2_MU_TPMA_LOCALITY_Marshal(TPMA_LOCALITY src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMA_LOCALITY_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMA_LOCALITY *dest)

    TSS2_RC Tss2_MU_TPMA_NV_Marshal(TPMA_NV src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMA_NV_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMA_NV *dest)

    TSS2_RC Tss2_MU_TPMA_OBJECT_Marshal(TPMA_OBJECT src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMA_OBJECT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMA_OBJECT *dest)

    TSS2_RC Tss2_MU_TPMA_PERMANENT_Marshal(TPMA_PERMANENT src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMA_PERMANENT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMA_PERMANENT *dest)

    TSS2_RC Tss2_MU_TPMA_SESSION_Marshal(TPMA_SESSION src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMA_SESSION_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMA_SESSION *dest)

    TSS2_RC Tss2_MU_TPMA_STARTUP_CLEAR_Marshal(TPMA_STARTUP_CLEAR src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMA_STARTUP_CLEAR_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMA_STARTUP_CLEAR *dest)

    TSS2_RC Tss2_MU_TPM2B_DIGEST_Marshal(const TPM2B_DIGEST *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_DIGEST_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_DIGEST *dest)

    TSS2_RC Tss2_MU_TPM2B_ATTEST_Marshal(const TPM2B_ATTEST *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_ATTEST_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_ATTEST *dest)

    TSS2_RC Tss2_MU_TPM2B_NAME_Marshal(const TPM2B_NAME *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_NAME_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_NAME *dest)

    TSS2_RC Tss2_MU_TPM2B_MAX_NV_BUFFER_Marshal(const TPM2B_MAX_NV_BUFFER *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_MAX_NV_BUFFER_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_MAX_NV_BUFFER *dest)

    TSS2_RC Tss2_MU_TPM2B_SENSITIVE_DATA_Marshal(const TPM2B_SENSITIVE_DATA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_SENSITIVE_DATA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_SENSITIVE_DATA *dest)

    TSS2_RC Tss2_MU_TPM2B_ECC_PARAMETER_Marshal(const TPM2B_ECC_PARAMETER *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_ECC_PARAMETER_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_ECC_PARAMETER *dest)

    TSS2_RC Tss2_MU_TPM2B_PUBLIC_KEY_RSA_Marshal(const TPM2B_PUBLIC_KEY_RSA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_PUBLIC_KEY_RSA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_PUBLIC_KEY_RSA *dest)

    TSS2_RC Tss2_MU_TPM2B_PRIVATE_KEY_RSA_Marshal(const TPM2B_PRIVATE_KEY_RSA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_PRIVATE_KEY_RSA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_PRIVATE_KEY_RSA *dest)

    TSS2_RC Tss2_MU_TPM2B_PRIVATE_Marshal(const TPM2B_PRIVATE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_PRIVATE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_PRIVATE *dest)

    TSS2_RC Tss2_MU_TPM2B_CONTEXT_SENSITIVE_Marshal(const TPM2B_CONTEXT_SENSITIVE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_CONTEXT_SENSITIVE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_CONTEXT_SENSITIVE *dest)

    TSS2_RC Tss2_MU_TPM2B_CONTEXT_DATA_Marshal(const TPM2B_CONTEXT_DATA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_CONTEXT_DATA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_CONTEXT_DATA *dest)

    TSS2_RC Tss2_MU_TPM2B_DATA_Marshal(const TPM2B_DATA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_DATA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_DATA *dest)

    TSS2_RC Tss2_MU_TPM2B_SYM_KEY_Marshal(const TPM2B_SYM_KEY *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_SYM_KEY_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_SYM_KEY *dest)

    TSS2_RC Tss2_MU_TPM2B_ECC_POINT_Marshal(const TPM2B_ECC_POINT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_ECC_POINT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_ECC_POINT *dest)

    TSS2_RC Tss2_MU_TPM2B_NV_PUBLIC_Marshal(const TPM2B_NV_PUBLIC *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_NV_PUBLIC_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_NV_PUBLIC *dest)

    TSS2_RC Tss2_MU_TPM2B_SENSITIVE_Marshal(const TPM2B_SENSITIVE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_SENSITIVE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_SENSITIVE *dest)

    TSS2_RC Tss2_MU_TPM2B_SENSITIVE_CREATE_Marshal(const TPM2B_SENSITIVE_CREATE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_SENSITIVE_CREATE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_SENSITIVE_CREATE *dest)

    TSS2_RC Tss2_MU_TPM2B_CREATION_DATA_Marshal(const TPM2B_CREATION_DATA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_CREATION_DATA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_CREATION_DATA *dest)

    TSS2_RC Tss2_MU_TPM2B_PUBLIC_Marshal(const TPM2B_PUBLIC *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_PUBLIC_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_PUBLIC *dest)

    TSS2_RC Tss2_MU_TPM2B_ENCRYPTED_SECRET_Marshal(const TPM2B_ENCRYPTED_SECRET *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_ENCRYPTED_SECRET_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_ENCRYPTED_SECRET *dest)

    TSS2_RC Tss2_MU_TPM2B_ID_OBJECT_Marshal(const TPM2B_ID_OBJECT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_ID_OBJECT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_ID_OBJECT *dest)

    TSS2_RC Tss2_MU_TPM2B_IV_Marshal(const TPM2B_IV *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_IV_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_IV *dest)

    TSS2_RC Tss2_MU_TPM2B_AUTH_Marshal(const TPM2B_AUTH *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_AUTH_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_AUTH *dest)

    TSS2_RC Tss2_MU_TPM2B_EVENT_Marshal(const TPM2B_EVENT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_EVENT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_EVENT *dest)

    TSS2_RC Tss2_MU_TPM2B_MAX_BUFFER_Marshal(const TPM2B_MAX_BUFFER *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_MAX_BUFFER_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_MAX_BUFFER *dest)

    TSS2_RC Tss2_MU_TPM2B_NONCE_Marshal(const TPM2B_NONCE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_NONCE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_NONCE *dest)

    TSS2_RC Tss2_MU_TPM2B_OPERAND_Marshal(const TPM2B_OPERAND *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_OPERAND_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_OPERAND *dest)

    TSS2_RC Tss2_MU_TPM2B_TIMEOUT_Marshal(const TPM2B_TIMEOUT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_TIMEOUT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_TIMEOUT *dest)

    TSS2_RC Tss2_MU_TPM2B_TEMPLATE_Marshal(const TPM2B_TEMPLATE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2B_TEMPLATE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPM2B_TEMPLATE *dest)

    TSS2_RC Tss2_MU_TPMS_CONTEXT_Marshal(const TPMS_CONTEXT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_CONTEXT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_CONTEXT *dest)

    TSS2_RC Tss2_MU_TPMS_TIME_INFO_Marshal(const TPMS_TIME_INFO *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_TIME_INFO_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_TIME_INFO *dest)

    TSS2_RC Tss2_MU_TPMS_ECC_POINT_Marshal(const TPMS_ECC_POINT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_ECC_POINT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_ECC_POINT *dest)

    TSS2_RC Tss2_MU_TPMS_NV_PUBLIC_Marshal(const TPMS_NV_PUBLIC *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_NV_PUBLIC_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_NV_PUBLIC *dest)

    TSS2_RC Tss2_MU_TPMS_ALG_PROPERTY_Marshal(const TPMS_ALG_PROPERTY *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_ALG_PROPERTY_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_ALG_PROPERTY *dest)

    TSS2_RC Tss2_MU_TPMS_ALGORITHM_DESCRIPTION_Marshal(const TPMS_ALGORITHM_DESCRIPTION *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_ALGORITHM_DESCRIPTION_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_ALGORITHM_DESCRIPTION *dest)

    TSS2_RC Tss2_MU_TPMS_TAGGED_PROPERTY_Marshal(const TPMS_TAGGED_PROPERTY *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_TAGGED_PROPERTY_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_TAGGED_PROPERTY *dest)

    TSS2_RC Tss2_MU_TPMS_TAGGED_POLICY_Marshal(const TPMS_TAGGED_POLICY *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_TAGGED_POLICY_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_TAGGED_POLICY *dest)

    TSS2_RC Tss2_MU_TPMS_CLOCK_INFO_Marshal(const TPMS_CLOCK_INFO *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_CLOCK_INFO_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_CLOCK_INFO *dest)

    TSS2_RC Tss2_MU_TPMS_TIME_ATTEST_INFO_Marshal(const TPMS_TIME_ATTEST_INFO *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_TIME_ATTEST_INFO_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_TIME_ATTEST_INFO *dest)

    TSS2_RC Tss2_MU_TPMS_CERTIFY_INFO_Marshal(const TPMS_CERTIFY_INFO *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_CERTIFY_INFO_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_CERTIFY_INFO *dest)

    TSS2_RC Tss2_MU_TPMS_COMMAND_AUDIT_INFO_Marshal(const TPMS_COMMAND_AUDIT_INFO *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_COMMAND_AUDIT_INFO_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_COMMAND_AUDIT_INFO *dest)

    TSS2_RC Tss2_MU_TPMS_SESSION_AUDIT_INFO_Marshal(const TPMS_SESSION_AUDIT_INFO *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_SESSION_AUDIT_INFO_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_SESSION_AUDIT_INFO *dest)

    TSS2_RC Tss2_MU_TPMS_CREATION_INFO_Marshal(const TPMS_CREATION_INFO *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_CREATION_INFO_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_CREATION_INFO *dest)

    TSS2_RC Tss2_MU_TPMS_NV_CERTIFY_INFO_Marshal(const TPMS_NV_CERTIFY_INFO *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_NV_CERTIFY_INFO_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_NV_CERTIFY_INFO *dest)

    TSS2_RC Tss2_MU_TPMS_AUTH_COMMAND_Marshal(const TPMS_AUTH_COMMAND *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_AUTH_COMMAND_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_AUTH_COMMAND *dest)

    TSS2_RC Tss2_MU_TPMS_AUTH_RESPONSE_Marshal(const TPMS_AUTH_RESPONSE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_AUTH_RESPONSE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_AUTH_RESPONSE *dest)

    TSS2_RC Tss2_MU_TPMS_SENSITIVE_CREATE_Marshal(const TPMS_SENSITIVE_CREATE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_SENSITIVE_CREATE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_SENSITIVE_CREATE *dest)

    TSS2_RC Tss2_MU_TPMS_SCHEME_HASH_Marshal(const TPMS_SCHEME_HASH *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_SCHEME_HASH_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_SCHEME_HASH *dest)

    TSS2_RC Tss2_MU_TPMS_SCHEME_ECDAA_Marshal(const TPMS_SCHEME_ECDAA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_SCHEME_ECDAA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_SCHEME_ECDAA *dest)

    TSS2_RC Tss2_MU_TPMS_SCHEME_XOR_Marshal(const TPMS_SCHEME_XOR *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_SCHEME_XOR_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_SCHEME_XOR *dest)

    TSS2_RC Tss2_MU_TPMS_SIGNATURE_RSA_Marshal(const TPMS_SIGNATURE_RSA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_SIGNATURE_RSA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_SIGNATURE_RSA *dest)

    TSS2_RC Tss2_MU_TPMS_SIGNATURE_ECC_Marshal(const TPMS_SIGNATURE_ECC *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_SIGNATURE_ECC_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_SIGNATURE_ECC *dest)

    TSS2_RC Tss2_MU_TPMS_NV_PIN_COUNTER_PARAMETERS_Marshal(const TPMS_NV_PIN_COUNTER_PARAMETERS *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_NV_PIN_COUNTER_PARAMETERS_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_NV_PIN_COUNTER_PARAMETERS *dest)

    TSS2_RC Tss2_MU_TPMS_CONTEXT_DATA_Marshal(const TPMS_CONTEXT_DATA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_CONTEXT_DATA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_CONTEXT_DATA *dest)

    TSS2_RC Tss2_MU_TPMS_PCR_SELECT_Marshal(const TPMS_PCR_SELECT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_PCR_SELECT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_PCR_SELECT *dest)

    TSS2_RC Tss2_MU_TPMS_PCR_SELECTION_Marshal(const TPMS_PCR_SELECTION *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_PCR_SELECTION_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_PCR_SELECTION *dest)

    TSS2_RC Tss2_MU_TPMS_TAGGED_PCR_SELECT_Marshal(const TPMS_TAGGED_PCR_SELECT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_TAGGED_PCR_SELECT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_TAGGED_PCR_SELECT *dest)

    TSS2_RC Tss2_MU_TPMS_QUOTE_INFO_Marshal(const TPMS_QUOTE_INFO *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_QUOTE_INFO_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_QUOTE_INFO *dest)

    TSS2_RC Tss2_MU_TPMS_CREATION_DATA_Marshal(const TPMS_CREATION_DATA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_CREATION_DATA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_CREATION_DATA *dest)

    TSS2_RC Tss2_MU_TPMS_ECC_PARMS_Marshal(const TPMS_ECC_PARMS *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_ECC_PARMS_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_ECC_PARMS *dest)

    TSS2_RC Tss2_MU_TPMS_ATTEST_Marshal(const TPMS_ATTEST *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_ATTEST_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_ATTEST *dest)

    TSS2_RC Tss2_MU_TPMS_ALGORITHM_DETAIL_ECC_Marshal(const TPMS_ALGORITHM_DETAIL_ECC *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_ALGORITHM_DETAIL_ECC_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_ALGORITHM_DETAIL_ECC *dest)

    TSS2_RC Tss2_MU_TPMS_CAPABILITY_DATA_Marshal(const TPMS_CAPABILITY_DATA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_CAPABILITY_DATA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_CAPABILITY_DATA *dest)

    TSS2_RC Tss2_MU_TPMS_KEYEDHASH_PARMS_Marshal(const TPMS_KEYEDHASH_PARMS *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_KEYEDHASH_PARMS_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_KEYEDHASH_PARMS *dest)

    TSS2_RC Tss2_MU_TPMS_RSA_PARMS_Marshal(const TPMS_RSA_PARMS *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_RSA_PARMS_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_RSA_PARMS *dest)

    TSS2_RC Tss2_MU_TPMS_SYMCIPHER_PARMS_Marshal(const TPMS_SYMCIPHER_PARMS *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_SYMCIPHER_PARMS_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_SYMCIPHER_PARMS *dest)

    TSS2_RC Tss2_MU_TPMS_AC_OUTPUT_Marshal(const TPMS_AC_OUTPUT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_AC_OUTPUT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_AC_OUTPUT *dest)

    TSS2_RC Tss2_MU_TPMS_ID_OBJECT_Marshal(const TPMS_ID_OBJECT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_ID_OBJECT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMS_ID_OBJECT *dest)

    TSS2_RC Tss2_MU_TPML_CC_Marshal(const TPML_CC *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_CC_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_CC *dest)

    TSS2_RC Tss2_MU_TPML_CCA_Marshal(const TPML_CCA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_CCA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_CCA *dest)

    TSS2_RC Tss2_MU_TPML_ALG_Marshal(const TPML_ALG *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_ALG_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_ALG *dest)

    TSS2_RC Tss2_MU_TPML_HANDLE_Marshal(const TPML_HANDLE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_HANDLE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_HANDLE *dest)

    TSS2_RC Tss2_MU_TPML_DIGEST_Marshal(const TPML_DIGEST *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_DIGEST_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_DIGEST *dest)

    TSS2_RC Tss2_MU_TPML_DIGEST_VALUES_Marshal(const TPML_DIGEST_VALUES *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_DIGEST_VALUES_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_DIGEST_VALUES *dest)

    TSS2_RC Tss2_MU_TPML_PCR_SELECTION_Marshal(const TPML_PCR_SELECTION *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_PCR_SELECTION_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_PCR_SELECTION *dest)

    TSS2_RC Tss2_MU_TPML_ALG_PROPERTY_Marshal(const TPML_ALG_PROPERTY *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_ALG_PROPERTY_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_ALG_PROPERTY *dest)

    TSS2_RC Tss2_MU_TPML_ECC_CURVE_Marshal(const TPML_ECC_CURVE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_ECC_CURVE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_ECC_CURVE *dest)

    TSS2_RC Tss2_MU_TPML_TAGGED_PCR_PROPERTY_Marshal(const TPML_TAGGED_PCR_PROPERTY *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_TAGGED_PCR_PROPERTY_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_TAGGED_PCR_PROPERTY *dest)

    TSS2_RC Tss2_MU_TPML_TAGGED_TPM_PROPERTY_Marshal(const TPML_TAGGED_TPM_PROPERTY *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_TAGGED_TPM_PROPERTY_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_TAGGED_TPM_PROPERTY *dest)

    TSS2_RC Tss2_MU_TPML_INTEL_PTT_PROPERTY_Marshal(const TPML_INTEL_PTT_PROPERTY *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_INTEL_PTT_PROPERTY_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_INTEL_PTT_PROPERTY *dest)

    TSS2_RC Tss2_MU_TPML_AC_CAPABILITIES_Marshal(const TPML_AC_CAPABILITIES *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPML_AC_CAPABILITIES_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPML_AC_CAPABILITIES *dest)

    TSS2_RC Tss2_MU_TPMU_HA_Marshal(const TPMU_HA *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_HA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_HA *dest)

    TSS2_RC Tss2_MU_TPMU_CAPABILITIES_Marshal(const TPMU_CAPABILITIES *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_CAPABILITIES_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_CAPABILITIES *dest)

    TSS2_RC Tss2_MU_TPMU_ATTEST_Marshal(const TPMU_ATTEST *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_ATTEST_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_ATTEST *dest)

    TSS2_RC Tss2_MU_TPMU_SYM_KEY_BITS_Marshal(const TPMU_SYM_KEY_BITS *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_SYM_KEY_BITS_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_SYM_KEY_BITS *dest)

    TSS2_RC Tss2_MU_TPMU_SYM_MODE_Marshal(const TPMU_SYM_MODE *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_SYM_MODE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_SYM_MODE *dest)

    TSS2_RC Tss2_MU_TPMU_SIG_SCHEME_Marshal(const TPMU_SIG_SCHEME *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_SIG_SCHEME_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_SIG_SCHEME *dest)

    TSS2_RC Tss2_MU_TPMU_KDF_SCHEME_Marshal(const TPMU_KDF_SCHEME *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_KDF_SCHEME_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_KDF_SCHEME *dest)

    TSS2_RC Tss2_MU_TPMU_ASYM_SCHEME_Marshal(const TPMU_ASYM_SCHEME *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_ASYM_SCHEME_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_ASYM_SCHEME *dest)

    TSS2_RC Tss2_MU_TPMU_SCHEME_KEYEDHASH_Marshal(const TPMU_SCHEME_KEYEDHASH *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_SCHEME_KEYEDHASH_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_SCHEME_KEYEDHASH *dest)

    TSS2_RC Tss2_MU_TPMU_SIGNATURE_Marshal(const TPMU_SIGNATURE *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_SIGNATURE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_SIGNATURE *dest)

    TSS2_RC Tss2_MU_TPMU_SENSITIVE_COMPOSITE_Marshal(const TPMU_SENSITIVE_COMPOSITE *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_SENSITIVE_COMPOSITE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_SENSITIVE_COMPOSITE *dest)

    TSS2_RC Tss2_MU_TPMU_ENCRYPTED_SECRET_Marshal(const TPMU_ENCRYPTED_SECRET *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_ENCRYPTED_SECRET_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_ENCRYPTED_SECRET *dest)

    TSS2_RC Tss2_MU_TPMU_PUBLIC_PARMS_Marshal(const TPMU_PUBLIC_PARMS *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_PUBLIC_PARMS_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_PUBLIC_PARMS *dest)

    TSS2_RC Tss2_MU_TPMU_PUBLIC_ID_Marshal(const TPMU_PUBLIC_ID *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_PUBLIC_ID_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_PUBLIC_ID *dest)

    TSS2_RC Tss2_MU_TPMU_NAME_Marshal(const TPMU_NAME *src, uint32_t selector_value, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMU_NAME_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, uint32_t selector_value, TPMU_NAME *dest)

    TSS2_RC Tss2_MU_TPMT_HA_Marshal(const TPMT_HA *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_HA_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_HA *dest)

    TSS2_RC Tss2_MU_TPMT_SYM_DEF_Marshal(const TPMT_SYM_DEF *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_SYM_DEF_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_SYM_DEF *dest)

    TSS2_RC Tss2_MU_TPMT_SYM_DEF_OBJECT_Marshal(const TPMT_SYM_DEF_OBJECT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_SYM_DEF_OBJECT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_SYM_DEF_OBJECT *dest)

    TSS2_RC Tss2_MU_TPMT_KEYEDHASH_SCHEME_Marshal(const TPMT_KEYEDHASH_SCHEME *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_KEYEDHASH_SCHEME_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_KEYEDHASH_SCHEME *dest)

    TSS2_RC Tss2_MU_TPMT_SIG_SCHEME_Marshal(const TPMT_SIG_SCHEME *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_SIG_SCHEME_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_SIG_SCHEME *dest)

    TSS2_RC Tss2_MU_TPMT_KDF_SCHEME_Marshal(const TPMT_KDF_SCHEME *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_KDF_SCHEME_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_KDF_SCHEME *dest)

    TSS2_RC Tss2_MU_TPMT_ASYM_SCHEME_Marshal(const TPMT_ASYM_SCHEME *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_ASYM_SCHEME_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_ASYM_SCHEME *dest)

    TSS2_RC Tss2_MU_TPMT_RSA_SCHEME_Marshal(const TPMT_RSA_SCHEME *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_RSA_SCHEME_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_RSA_SCHEME *dest)

    TSS2_RC Tss2_MU_TPMT_RSA_DECRYPT_Marshal(const TPMT_RSA_DECRYPT *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_RSA_DECRYPT_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_RSA_DECRYPT *dest)

    TSS2_RC Tss2_MU_TPMT_ECC_SCHEME_Marshal(const TPMT_ECC_SCHEME *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_ECC_SCHEME_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_ECC_SCHEME *dest)

    TSS2_RC Tss2_MU_TPMT_SIGNATURE_Marshal(const TPMT_SIGNATURE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_SIGNATURE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_SIGNATURE *dest)

    TSS2_RC Tss2_MU_TPMT_SENSITIVE_Marshal(const TPMT_SENSITIVE *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_SENSITIVE_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_SENSITIVE *dest)

    TSS2_RC Tss2_MU_TPMT_PUBLIC_Marshal(const TPMT_PUBLIC *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_PUBLIC_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_PUBLIC *dest)

    TSS2_RC Tss2_MU_TPMT_PUBLIC_PARMS_Marshal(const TPMT_PUBLIC_PARMS *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_PUBLIC_PARMS_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_PUBLIC_PARMS *dest)

    TSS2_RC Tss2_MU_TPMT_TK_CREATION_Marshal(const TPMT_TK_CREATION *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_TK_CREATION_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_TK_CREATION *dest)

    TSS2_RC Tss2_MU_TPMT_TK_VERIFIED_Marshal(const TPMT_TK_VERIFIED *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_TK_VERIFIED_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_TK_VERIFIED *dest)

    TSS2_RC Tss2_MU_TPMT_TK_AUTH_Marshal(const TPMT_TK_AUTH *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_TK_AUTH_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_TK_AUTH *dest)

    TSS2_RC Tss2_MU_TPMT_TK_HASHCHECK_Marshal(const TPMT_TK_HASHCHECK *src, uint8_t buffer[], size_t buffer_size, size_t *offset)

    TSS2_RC Tss2_MU_TPMT_TK_HASHCHECK_Unmarshal(const uint8_t buffer[], size_t buffer_size, size_t *offset, TPMT_TK_HASHCHECK *dest)

    TSS2_RC Tss2_MU_TPM2_HANDLE_Marshal(TPM2_HANDLE in, uint8_t *buffer, size_t size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2_HANDLE_Unmarshal(const uint8_t buffer[], size_t size, size_t *offset, TPM2_HANDLE *out)

    TSS2_RC Tss2_MU_TPMI_ALG_HASH_Marshal(TPMI_ALG_HASH in, uint8_t *buffer, size_t size, size_t *offset)

    TSS2_RC Tss2_MU_TPMI_ALG_HASH_Unmarshal(const uint8_t buffer[], size_t size, size_t *offset, TPMI_ALG_HASH *out)

    TSS2_RC Tss2_MU_TPM2_SE_Marshal(TPM2_SE in, uint8_t *buffer, size_t size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2_SE_Unmarshal(const uint8_t buffer[], size_t size, size_t *offset, TPM2_SE *out)

    TSS2_RC Tss2_MU_TPM2_NT_Marshal(TPM2_NT in, uint8_t *buffer, size_t size, size_t *offset)

    TSS2_RC Tss2_MU_TPM2_NT_Unmarshal(const uint8_t buffer[], size_t size, size_t *offset, TPM2_NT *out)

    TSS2_RC Tss2_MU_TPMS_EMPTY_Marshal(const TPMS_EMPTY *in, uint8_t *buffer, size_t size, size_t *offset)

    TSS2_RC Tss2_MU_TPMS_EMPTY_Unmarshal(const uint8_t buffer[], size_t size, size_t *offset, TPMS_EMPTY *out)

