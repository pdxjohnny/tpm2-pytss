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
    INT8,
    UINT16,
    UINT32,
    UINT64,
    UINT8,
)


cdef extern from "<tss2/tss2_tpm2_types.h>":
    ctypedef UINT16 TPM2_ALG_ID

    ctypedef UINT16 TPM2_ECC_CURVE

    ctypedef UINT32 TPM2_CC

    ctypedef UINT32 TPM2_ALGORITHM_ID

    ctypedef UINT32 TPM2_MODIFIER_INDICATOR

    ctypedef UINT32 TPM2_AUTHORIZATION_SIZE

    ctypedef UINT32 TPM2_PARAMETER_SIZE

    ctypedef UINT16 TPM2_KEY_SIZE

    ctypedef UINT16 TPM2_KEY_BITS

    ctypedef UINT32 TPM2_SPEC

    ctypedef UINT32 TPM2_GENERATED

    ctypedef UINT32 TPM2_RC

    ctypedef INT8 TPM2_CLOCK_ADJUST

    ctypedef UINT16 TPM2_EO

    ctypedef UINT16 TPM2_ST

    ctypedef UINT16 TPM2_SU

    ctypedef UINT8 TPM2_SE

    ctypedef UINT32 TPM2_CAP

    ctypedef UINT32 TPM2_PT

    ctypedef UINT32 TPM2_PT_PCR

    ctypedef UINT32 TPM2_PS

    ctypedef UINT32 TPM2_HANDLE

    ctypedef UINT8 TPM2_HT

    ctypedef TPM2_HANDLE TPM2_RH

    ctypedef TPM2_HANDLE TPM2_HC

    ctypedef uint32_t TPMA_ALGORITHM

    ctypedef uint32_t TPMA_OBJECT

    ctypedef UINT8 TPMA_SESSION

    ctypedef UINT8 TPMA_LOCALITY

    ctypedef uint32_t TPMA_PERMANENT

    ctypedef uint32_t TPMA_STARTUP_CLEAR

    ctypedef uint32_t TPMA_MEMORY

    ctypedef uint32_t TPMA_CC

    ctypedef uint32_t TPMA_MODES

    ctypedef BYTE TPMI_YES_NO

    ctypedef TPM2_HANDLE TPMI_DH_OBJECT

    ctypedef TPM2_HANDLE TPMI_DH_PERSISTENT

    ctypedef TPM2_HANDLE TPMI_DH_ENTITY

    ctypedef TPM2_HANDLE TPMI_DH_PCR

    ctypedef TPM2_HANDLE TPMI_SH_AUTH_SESSION

    ctypedef TPM2_HANDLE TPMI_SH_HMAC

    ctypedef TPM2_HANDLE TPMI_SH_POLICY

    ctypedef TPM2_HANDLE TPMI_DH_CONTEXT

    ctypedef TPM2_HANDLE TPMI_RH_HIERARCHY

    ctypedef TPM2_HANDLE TPMI_RH_ENABLES

    ctypedef TPM2_HANDLE TPMI_RH_HIERARCHY_AUTH

    ctypedef TPM2_HANDLE TPMI_RH_PLATFORM

    ctypedef TPM2_HANDLE TPMI_RH_OWNER

    ctypedef TPM2_HANDLE TPMI_RH_ENDORSEMENT

    ctypedef TPM2_HANDLE TPMI_RH_PROVISION

    ctypedef TPM2_HANDLE TPMI_RH_CLEAR

    ctypedef TPM2_HANDLE TPMI_RH_NV_AUTH

    ctypedef TPM2_HANDLE TPMI_RH_LOCKOUT

    ctypedef TPM2_HANDLE TPMI_RH_NV_INDEX

    ctypedef TPM2_ALG_ID TPMI_ALG_HASH

    ctypedef TPM2_ALG_ID TPMI_ALG_ASYM

    ctypedef TPM2_ALG_ID TPMI_ALG_SYM

    ctypedef TPM2_ALG_ID TPMI_ALG_SYM_OBJECT

    ctypedef TPM2_ALG_ID TPMI_ALG_SYM_MODE

    ctypedef TPM2_ALG_ID TPMI_ALG_KDF

    ctypedef TPM2_ALG_ID TPMI_ALG_SIG_SCHEME

    ctypedef TPM2_ALG_ID TPMI_ECC_KEY_EXCHANGE

    ctypedef TPM2_ST TPMI_ST_COMMAND_TAG

    struct TPMS_EMPTY:
        BYTE empty[1]

    struct TPMS_ALGORITHM_DESCRIPTION:
        TPM2_ALG_ID alg
        TPMA_ALGORITHM attributes

    union TPMU_HA:
        BYTE sha1[20]
        BYTE sha256[32]
        BYTE sha384[48]
        BYTE sha512[64]
        BYTE sm3_256[32]

    struct TPMT_HA:
        TPMI_ALG_HASH hashAlg
        TPMU_HA digest

    struct TPM2B_DIGEST:
        UINT16 size
        BYTE buffer[8]

    struct TPM2B_DATA:
        UINT16 size
        BYTE buffer[8]

    ctypedef TPM2B_DIGEST TPM2B_NONCE

    ctypedef TPM2B_DIGEST TPM2B_AUTH

    ctypedef TPM2B_DIGEST TPM2B_OPERAND

    struct TPM2B_EVENT:
        UINT16 size
        BYTE buffer[1024]

    struct TPM2B_MAX_BUFFER:
        UINT16 size
        BYTE buffer[1024]

    struct TPM2B_MAX_NV_BUFFER:
        UINT16 size
        BYTE buffer[2048]

    ctypedef TPM2B_DIGEST TPM2B_TIMEOUT

    struct TPM2B_IV:
        UINT16 size
        BYTE buffer[16]

    union TPMU_NAME:
        TPMT_HA digest
        TPM2_HANDLE handle

    struct TPM2B_NAME:
        UINT16 size
        BYTE name[8]

    struct TPMS_PCR_SELECT:
        UINT8 sizeofSelect
        BYTE pcrSelect[4]

    struct TPMS_PCR_SELECTION:
        TPMI_ALG_HASH hash
        UINT8 sizeofSelect
        BYTE pcrSelect[4]

    struct TPMT_TK_CREATION:
        TPM2_ST tag
        TPMI_RH_HIERARCHY hierarchy
        TPM2B_DIGEST digest

    struct TPMT_TK_VERIFIED:
        TPM2_ST tag
        TPMI_RH_HIERARCHY hierarchy
        TPM2B_DIGEST digest

    struct TPMT_TK_AUTH:
        TPM2_ST tag
        TPMI_RH_HIERARCHY hierarchy
        TPM2B_DIGEST digest

    struct TPMT_TK_HASHCHECK:
        TPM2_ST tag
        TPMI_RH_HIERARCHY hierarchy
        TPM2B_DIGEST digest

    struct TPMS_ALG_PROPERTY:
        TPM2_ALG_ID alg
        TPMA_ALGORITHM algProperties

    struct TPMS_TAGGED_PROPERTY:
        TPM2_PT property
        UINT32 value

    struct TPMS_TAGGED_PCR_SELECT:
        TPM2_PT_PCR tag
        UINT8 sizeofSelect
        BYTE pcrSelect[4]

    struct TPMS_TAGGED_POLICY:
        TPM2_HANDLE handle
        TPMT_HA policyHash

    struct TPML_CC:
        UINT32 count
        TPM2_CC commandCodes[256]

    struct TPML_CCA:
        UINT32 count
        TPMA_CC commandAttributes[256]

    struct TPML_ALG:
        UINT32 count
        TPM2_ALG_ID algorithms[128]

    struct TPML_HANDLE:
        UINT32 count
        TPM2_HANDLE handle[8]

    struct TPML_DIGEST:
        UINT32 count
        TPM2B_DIGEST digests[8]

    struct TPML_DIGEST_VALUES:
        UINT32 count
        TPMT_HA digests[16]

    struct TPML_PCR_SELECTION:
        UINT32 count
        TPMS_PCR_SELECTION pcrSelections[16]

    struct TPML_ALG_PROPERTY:
        UINT32 count
        TPMS_ALG_PROPERTY algProperties[8]

    struct TPML_TAGGED_TPM_PROPERTY:
        UINT32 count
        TPMS_TAGGED_PROPERTY tpmProperty[8]

    struct TPML_TAGGED_PCR_PROPERTY:
        UINT32 count
        TPMS_TAGGED_PCR_SELECT pcrProperty[8]

    struct TPML_ECC_CURVE:
        UINT32 count
        TPM2_ECC_CURVE eccCurves[8]

    struct TPML_INTEL_PTT_PROPERTY:
        UINT32 count
        UINT32 property[8]

    union TPMU_CAPABILITIES:
        TPML_ALG_PROPERTY algorithms
        TPML_HANDLE handles
        TPML_CCA command
        TPML_CC ppCommands
        TPML_CC auditCommands
        TPML_PCR_SELECTION assignedPCR
        TPML_TAGGED_TPM_PROPERTY tpmProperties
        TPML_TAGGED_PCR_PROPERTY pcrProperties
        TPML_ECC_CURVE eccCurves
        TPML_INTEL_PTT_PROPERTY intelPttProperty

    struct TPMS_CAPABILITY_DATA:
        TPM2_CAP capability
        TPMU_CAPABILITIES data

    struct TPMS_CLOCK_INFO:
        UINT64 clock
        UINT32 resetCount
        UINT32 restartCount
        TPMI_YES_NO safe

    struct TPMS_TIME_INFO:
        UINT64 time
        TPMS_CLOCK_INFO clockInfo

    struct TPMS_TIME_ATTEST_INFO:
        TPMS_TIME_INFO time
        UINT64 firmwareVersion

    struct TPMS_CERTIFY_INFO:
        TPM2B_NAME name
        TPM2B_NAME qualifiedName

    struct TPMS_QUOTE_INFO:
        TPML_PCR_SELECTION pcrSelect
        TPM2B_DIGEST pcrDigest

    struct TPMS_COMMAND_AUDIT_INFO:
        UINT64 auditCounter
        TPM2_ALG_ID digestAlg
        TPM2B_DIGEST auditDigest
        TPM2B_DIGEST commandDigest

    struct TPMS_SESSION_AUDIT_INFO:
        TPMI_YES_NO exclusiveSession
        TPM2B_DIGEST sessionDigest

    struct TPMS_CREATION_INFO:
        TPM2B_NAME objectName
        TPM2B_DIGEST creationHash

    struct TPMS_NV_CERTIFY_INFO:
        TPM2B_NAME indexName
        UINT16 offset
        TPM2B_MAX_NV_BUFFER nvContents

    ctypedef TPM2_ST TPMI_ST_ATTEST

    union TPMU_ATTEST:
        TPMS_CERTIFY_INFO certify
        TPMS_CREATION_INFO creation
        TPMS_QUOTE_INFO quote
        TPMS_COMMAND_AUDIT_INFO commandAudit
        TPMS_SESSION_AUDIT_INFO sessionAudit
        TPMS_TIME_ATTEST_INFO time
        TPMS_NV_CERTIFY_INFO nv

    struct TPMS_ATTEST:
        TPM2_GENERATED magic
        TPMI_ST_ATTEST type
        TPM2B_NAME qualifiedSigner
        TPM2B_DATA extraData
        TPMS_CLOCK_INFO clockInfo
        UINT64 firmwareVersion
        TPMU_ATTEST attested

    struct TPM2B_ATTEST:
        UINT16 size
        BYTE attestationData[8]

    struct TPMS_AUTH_COMMAND:
        TPMI_SH_AUTH_SESSION sessionHandle
        TPM2B_NONCE nonce
        TPMA_SESSION sessionAttributes
        TPM2B_AUTH hmac

    struct TPMS_AUTH_RESPONSE:
        TPM2B_NONCE nonce
        TPMA_SESSION sessionAttributes
        TPM2B_AUTH hmac

    ctypedef TPM2_KEY_BITS TPMI_AES_KEY_BITS

    ctypedef TPM2_KEY_BITS TPMI_SM4_KEY_BITS

    ctypedef TPM2_KEY_BITS TPMI_CAMELLIA_KEY_BITS

    union TPMU_SYM_KEY_BITS:
        TPMI_AES_KEY_BITS aes
        TPMI_SM4_KEY_BITS sm4
        TPMI_CAMELLIA_KEY_BITS camellia
        TPM2_KEY_BITS sym
        TPMI_ALG_HASH exclusiveOr

    union TPMU_SYM_MODE:
        TPMI_ALG_SYM_MODE aes
        TPMI_ALG_SYM_MODE sm4
        TPMI_ALG_SYM_MODE camellia
        TPMI_ALG_SYM_MODE sym

    struct TPMT_SYM_DEF:
        TPMI_ALG_SYM algorithm
        TPMU_SYM_KEY_BITS keyBits
        TPMU_SYM_MODE mode

    struct TPMT_SYM_DEF_OBJECT:
        TPMI_ALG_SYM_OBJECT algorithm
        TPMU_SYM_KEY_BITS keyBits
        TPMU_SYM_MODE mode

    struct TPM2B_SYM_KEY:
        UINT16 size
        BYTE buffer[32]

    struct TPMS_SYMCIPHER_PARMS:
        TPMT_SYM_DEF_OBJECT sym

    struct TPM2B_SENSITIVE_DATA:
        UINT16 size
        BYTE buffer[256]

    struct TPMS_SENSITIVE_CREATE:
        TPM2B_AUTH userAuth
        TPM2B_SENSITIVE_DATA data

    struct TPM2B_SENSITIVE_CREATE:
        UINT16 size
        TPMS_SENSITIVE_CREATE sensitive

    struct TPMS_SCHEME_HASH:
        TPMI_ALG_HASH hashAlg

    struct TPMS_SCHEME_ECDAA:
        TPMI_ALG_HASH hashAlg
        UINT16 count

    ctypedef TPM2_ALG_ID TPMI_ALG_KEYEDHASH_SCHEME

    ctypedef TPMS_SCHEME_HASH TPMS_SCHEME_HMAC

    struct TPMS_SCHEME_XOR:
        TPMI_ALG_HASH hashAlg
        TPMI_ALG_KDF kdf

    union TPMU_SCHEME_KEYEDHASH:
        TPMS_SCHEME_HMAC hmac
        TPMS_SCHEME_XOR exclusiveOr

    struct TPMT_KEYEDHASH_SCHEME:
        TPMI_ALG_KEYEDHASH_SCHEME scheme
        TPMU_SCHEME_KEYEDHASH details

    ctypedef TPMS_SCHEME_HASH TPMS_SIG_SCHEME_RSASSA

    ctypedef TPMS_SCHEME_HASH TPMS_SIG_SCHEME_RSAPSS

    ctypedef TPMS_SCHEME_HASH TPMS_SIG_SCHEME_ECDSA

    ctypedef TPMS_SCHEME_HASH TPMS_SIG_SCHEME_SM2

    ctypedef TPMS_SCHEME_HASH TPMS_SIG_SCHEME_ECSCHNORR

    ctypedef TPMS_SCHEME_ECDAA TPMS_SIG_SCHEME_ECDAA

    union TPMU_SIG_SCHEME:
        TPMS_SIG_SCHEME_RSASSA rsassa
        TPMS_SIG_SCHEME_RSAPSS rsapss
        TPMS_SIG_SCHEME_ECDSA ecdsa
        TPMS_SIG_SCHEME_ECDAA ecdaa
        TPMS_SIG_SCHEME_SM2 sm2
        TPMS_SIG_SCHEME_ECSCHNORR ecschnorr
        TPMS_SCHEME_HMAC hmac
        TPMS_SCHEME_HASH any

    struct TPMT_SIG_SCHEME:
        TPMI_ALG_SIG_SCHEME scheme
        TPMU_SIG_SCHEME details

    ctypedef TPMS_SCHEME_HASH TPMS_ENC_SCHEME_OAEP

    ctypedef TPMS_EMPTY TPMS_ENC_SCHEME_RSAES

    ctypedef TPMS_SCHEME_HASH TPMS_KEY_SCHEME_ECDH

    ctypedef TPMS_SCHEME_HASH TPMS_KEY_SCHEME_ECMQV

    ctypedef TPMS_SCHEME_HASH TPMS_SCHEME_MGF1

    ctypedef TPMS_SCHEME_HASH TPMS_SCHEME_KDF1_SP800_56A

    ctypedef TPMS_SCHEME_HASH TPMS_SCHEME_KDF2

    ctypedef TPMS_SCHEME_HASH TPMS_SCHEME_KDF1_SP800_108

    union TPMU_KDF_SCHEME:
        TPMS_SCHEME_MGF1 mgf1
        TPMS_SCHEME_KDF1_SP800_56A kdf1_sp800_56a
        TPMS_SCHEME_KDF2 kdf2
        TPMS_SCHEME_KDF1_SP800_108 kdf1_sp800_108

    struct TPMT_KDF_SCHEME:
        TPMI_ALG_KDF scheme
        TPMU_KDF_SCHEME details

    ctypedef TPM2_ALG_ID TPMI_ALG_ASYM_SCHEME

    union TPMU_ASYM_SCHEME:
        TPMS_KEY_SCHEME_ECDH ecdh
        TPMS_KEY_SCHEME_ECMQV ecmqv
        TPMS_SIG_SCHEME_RSASSA rsassa
        TPMS_SIG_SCHEME_RSAPSS rsapss
        TPMS_SIG_SCHEME_ECDSA ecdsa
        TPMS_SIG_SCHEME_ECDAA ecdaa
        TPMS_SIG_SCHEME_SM2 sm2
        TPMS_SIG_SCHEME_ECSCHNORR ecschnorr
        TPMS_ENC_SCHEME_RSAES rsaes
        TPMS_ENC_SCHEME_OAEP oaep
        TPMS_SCHEME_HASH anySig

    struct TPMT_ASYM_SCHEME:
        TPMI_ALG_ASYM_SCHEME scheme
        TPMU_ASYM_SCHEME details

    ctypedef TPM2_ALG_ID TPMI_ALG_RSA_SCHEME

    struct TPMT_RSA_SCHEME:
        TPMI_ALG_RSA_SCHEME scheme
        TPMU_ASYM_SCHEME details

    ctypedef TPM2_ALG_ID TPMI_ALG_RSA_DECRYPT

    struct TPMT_RSA_DECRYPT:
        TPMI_ALG_RSA_DECRYPT scheme
        TPMU_ASYM_SCHEME details

    struct TPM2B_PUBLIC_KEY_RSA:
        UINT16 size
        BYTE buffer[512]

    ctypedef TPM2_KEY_BITS TPMI_RSA_KEY_BITS

    struct TPM2B_PRIVATE_KEY_RSA:
        UINT16 size
        BYTE buffer[4]

    struct TPM2B_ECC_PARAMETER:
        UINT16 size
        BYTE buffer[128]

    struct TPMS_ECC_POINT:
        TPM2B_ECC_PARAMETER x
        TPM2B_ECC_PARAMETER y

    struct TPM2B_ECC_POINT:
        UINT16 size
        TPMS_ECC_POINT point

    ctypedef TPM2_ALG_ID TPMI_ALG_ECC_SCHEME

    ctypedef TPM2_ECC_CURVE TPMI_ECC_CURVE

    struct TPMT_ECC_SCHEME:
        TPMI_ALG_ECC_SCHEME scheme
        TPMU_ASYM_SCHEME details

    struct TPMS_ALGORITHM_DETAIL_ECC:
        TPM2_ECC_CURVE curveID
        UINT16 keySize
        TPMT_KDF_SCHEME kdf
        TPMT_ECC_SCHEME sign
        TPM2B_ECC_PARAMETER p
        TPM2B_ECC_PARAMETER a
        TPM2B_ECC_PARAMETER b
        TPM2B_ECC_PARAMETER gX
        TPM2B_ECC_PARAMETER gY
        TPM2B_ECC_PARAMETER n
        TPM2B_ECC_PARAMETER h

    struct TPMS_SIGNATURE_RSA:
        TPMI_ALG_HASH hash
        TPM2B_PUBLIC_KEY_RSA sig

    ctypedef TPMS_SIGNATURE_RSA TPMS_SIGNATURE_RSASSA

    ctypedef TPMS_SIGNATURE_RSA TPMS_SIGNATURE_RSAPSS

    struct TPMS_SIGNATURE_ECC:
        TPMI_ALG_HASH hash
        TPM2B_ECC_PARAMETER signatureR
        TPM2B_ECC_PARAMETER signatureS

    ctypedef TPMS_SIGNATURE_ECC TPMS_SIGNATURE_ECDSA

    ctypedef TPMS_SIGNATURE_ECC TPMS_SIGNATURE_ECDAA

    ctypedef TPMS_SIGNATURE_ECC TPMS_SIGNATURE_SM2

    ctypedef TPMS_SIGNATURE_ECC TPMS_SIGNATURE_ECSCHNORR

    union TPMU_SIGNATURE:
        TPMS_SIGNATURE_RSASSA rsassa
        TPMS_SIGNATURE_RSAPSS rsapss
        TPMS_SIGNATURE_ECDSA ecdsa
        TPMS_SIGNATURE_ECDAA ecdaa
        TPMS_SIGNATURE_SM2 sm2
        TPMS_SIGNATURE_ECSCHNORR ecschnorr
        TPMT_HA hmac
        TPMS_SCHEME_HASH any

    struct TPMT_SIGNATURE:
        TPMI_ALG_SIG_SCHEME sigAlg
        TPMU_SIGNATURE signature

    union TPMU_ENCRYPTED_SECRET:
        BYTE ecc[8]
        BYTE rsa[512]
        BYTE symmetric[8]
        BYTE keyedHash[8]

    struct TPM2B_ENCRYPTED_SECRET:
        UINT16 size
        BYTE secret[8]

    ctypedef TPM2_ALG_ID TPMI_ALG_PUBLIC

    union TPMU_PUBLIC_ID:
        TPM2B_DIGEST keyedHash
        TPM2B_DIGEST sym
        TPM2B_PUBLIC_KEY_RSA rsa
        TPMS_ECC_POINT ecc

    struct TPMS_KEYEDHASH_PARMS:
        TPMT_KEYEDHASH_SCHEME scheme

    struct TPMS_ASYM_PARMS:
        TPMT_SYM_DEF_OBJECT symmetric
        TPMT_ASYM_SCHEME scheme

    struct TPMS_RSA_PARMS:
        TPMT_SYM_DEF_OBJECT symmetric
        TPMT_RSA_SCHEME scheme
        TPMI_RSA_KEY_BITS keyBits
        UINT32 exponent

    struct TPMS_ECC_PARMS:
        TPMT_SYM_DEF_OBJECT symmetric
        TPMT_ECC_SCHEME scheme
        TPMI_ECC_CURVE curveID
        TPMT_KDF_SCHEME kdf

    union TPMU_PUBLIC_PARMS:
        TPMS_KEYEDHASH_PARMS keyedHashDetail
        TPMS_SYMCIPHER_PARMS symDetail
        TPMS_RSA_PARMS rsaDetail
        TPMS_ECC_PARMS eccDetail
        TPMS_ASYM_PARMS asymDetail

    struct TPMT_PUBLIC_PARMS:
        TPMI_ALG_PUBLIC type
        TPMU_PUBLIC_PARMS parameters

    struct TPMT_PUBLIC:
        TPMI_ALG_PUBLIC type
        TPMI_ALG_HASH nameAlg
        TPMA_OBJECT objectAttributes
        TPM2B_DIGEST authPolicy
        TPMU_PUBLIC_PARMS parameters
        TPMU_PUBLIC_ID unique

    struct TPM2B_PUBLIC:
        UINT16 size
        TPMT_PUBLIC publicArea

    struct TPM2B_TEMPLATE:
        UINT16 size
        BYTE buffer[8]

    struct TPM2B_PRIVATE_VENDOR_SPECIFIC:
        UINT16 size
        BYTE buffer[4]

    union TPMU_SENSITIVE_COMPOSITE:
        TPM2B_PRIVATE_KEY_RSA rsa
        TPM2B_ECC_PARAMETER ecc
        TPM2B_SENSITIVE_DATA bits
        TPM2B_SYM_KEY sym
        TPM2B_PRIVATE_VENDOR_SPECIFIC any

    struct TPMT_SENSITIVE:
        TPMI_ALG_PUBLIC sensitiveType
        TPM2B_AUTH authValue
        TPM2B_DIGEST seedValue
        TPMU_SENSITIVE_COMPOSITE sensitive

    struct TPM2B_SENSITIVE:
        UINT16 size
        TPMT_SENSITIVE sensitiveArea

    struct _PRIVATE:
        TPM2B_DIGEST integrityOuter
        TPM2B_DIGEST integrityInner
        TPM2B_SENSITIVE sensitive

    struct TPM2B_PRIVATE:
        UINT16 size
        BYTE buffer[8]

    struct TPMS_ID_OBJECT:
        TPM2B_DIGEST integrityHMAC
        TPM2B_DIGEST encIdentity

    struct TPM2B_ID_OBJECT:
        UINT16 size
        BYTE credential[8]

    ctypedef uint32_t TPM2_NV_INDEX

    ctypedef UINT8 TPM2_NT

    struct TPMS_NV_PIN_COUNTER_PARAMETERS:
        UINT32 pinCount
        UINT32 pinLimit

    ctypedef uint32_t TPMA_NV

    struct TPMS_NV_PUBLIC:
        TPMI_RH_NV_INDEX nvIndex
        TPMI_ALG_HASH nameAlg
        TPMA_NV attributes
        TPM2B_DIGEST authPolicy
        UINT16 dataSize

    struct TPM2B_NV_PUBLIC:
        UINT16 size
        TPMS_NV_PUBLIC nvPublic

    struct TPM2B_CONTEXT_SENSITIVE:
        UINT16 size
        BYTE buffer[5120]

    struct TPMS_CONTEXT_DATA:
        TPM2B_DIGEST integrity
        TPM2B_CONTEXT_SENSITIVE encrypted

    struct TPM2B_CONTEXT_DATA:
        UINT16 size
        BYTE buffer[8]

    struct TPMS_CONTEXT:
        UINT64 sequence
        TPMI_DH_CONTEXT savedHandle
        TPMI_RH_HIERARCHY hierarchy
        TPM2B_CONTEXT_DATA contextBlob

    struct TPMS_CREATION_DATA:
        TPML_PCR_SELECTION pcrSelect
        TPM2B_DIGEST pcrDigest
        TPMA_LOCALITY locality
        TPM2_ALG_ID parentNameAlg
        TPM2B_NAME parentName
        TPM2B_NAME parentQualifiedName
        TPM2B_DATA outsideInfo

    struct TPM2B_CREATION_DATA:
        UINT16 size
        TPMS_CREATION_DATA creationData

    ctypedef UINT32 TPM_AT

    ctypedef UINT32 TPM_EA

    ctypedef TPM2_HANDLE TPMI_RH_AC

    struct TPMS_AC_OUTPUT:
        TPM_AT tag
        UINT32 data

    struct TPML_AC_CAPABILITIES:
        UINT32 count
        TPMS_AC_OUTPUT acCapabilities[8]

