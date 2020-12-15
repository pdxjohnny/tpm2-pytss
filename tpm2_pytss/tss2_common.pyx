from tss2_typedefs cimport *

# This is the Cython verison of tss2_common.h
TSS2_API_VERSION_1_2_1_108 = True

TSS2_ABI_VERSION_CURRENT = TSS2_ABI_VERSION(1, 2, 1, 108)

TSS2_RC_LAYER_MASK     = TSS2_RC_LAYER(0xff)

# These layer codes are reserved for software layers defined in the TCG
# specifications.
TSS2_TPM_RC_LAYER           = TSS2_RC_LAYER(0)
TSS2_FEATURE_RC_LAYER       = TSS2_RC_LAYER(6)
TSS2_ESAPI_RC_LAYER         = TSS2_RC_LAYER(7)
TSS2_SYS_RC_LAYER           = TSS2_RC_LAYER(8)
TSS2_MU_RC_LAYER            = TSS2_RC_LAYER(9)
TSS2_TCTI_RC_LAYER          = TSS2_RC_LAYER(10)
TSS2_RESMGR_RC_LAYER        = TSS2_RC_LAYER(11)
TSS2_RESMGR_TPM_RC_LAYER    = TSS2_RC_LAYER(12)

# Base return codes.
# These base codes indicate the error that occurred. They are
# logical-ORed with a layer code to produce the TSS2 return value.
TSS2_BASE_RC_GENERAL_FAILURE         =  1 #  Catch all for all errors not otherwise specified
TSS2_BASE_RC_NOT_IMPLEMENTED         =  2 #  If called functionality isn't implemented
TSS2_BASE_RC_BAD_CONTEXT             =  3 #  A context structure is bad
TSS2_BASE_RC_ABI_MISMATCH            =  4 #  Passed in ABI version doesn't match called module's ABI version
TSS2_BASE_RC_BAD_REFERENCE           =  5 #  A pointer is NULL that isn't allowed to be NULL.
TSS2_BASE_RC_INSUFFICIENT_BUFFER     =  6 #  A buffer isn't large enough
TSS2_BASE_RC_BAD_SEQUENCE            =  7 #  Function called in the wrong order
TSS2_BASE_RC_NO_CONNECTION           =  8 #  Fails to connect to next lower layer
TSS2_BASE_RC_TRY_AGAIN               =  9 #  Operation timed out; function must be called again to be completed
TSS2_BASE_RC_IO_ERROR                = 10 #  IO failure
TSS2_BASE_RC_BAD_VALUE               = 11 #  A parameter has a bad value
TSS2_BASE_RC_NOT_PERMITTED           = 12 #  Operation not permitted.
TSS2_BASE_RC_INVALID_SESSIONS        = 13 #  Session structures were sent, but command doesn't use them or doesn't use the specifed number of them
TSS2_BASE_RC_NO_DECRYPT_PARAM        = 14 #  If function called that uses decrypt parameter, but command doesn't support crypt parameter.
TSS2_BASE_RC_NO_ENCRYPT_PARAM        = 15 #  If function called that uses encrypt parameter, but command doesn't support encrypt parameter.
TSS2_BASE_RC_BAD_SIZE                = 16 #  If size of a parameter is incorrect
TSS2_BASE_RC_MALFORMED_RESPONSE      = 17 #  Response is malformed
TSS2_BASE_RC_INSUFFICIENT_CONTEXT    = 18 #  Context not large enough
TSS2_BASE_RC_INSUFFICIENT_RESPONSE   = 19 #  Response is not long enough
TSS2_BASE_RC_INCOMPATIBLE_TCTI       = 20 #  Unknown or unusable TCTI version
TSS2_BASE_RC_NOT_SUPPORTED           = 21 #  Functionality not supported.
TSS2_BASE_RC_BAD_TCTI_STRUCTURE      = 22 #  TCTI context is bad.
TSS2_BASE_RC_MEMORY                  = 23 #  memory allocation failed
TSS2_BASE_RC_BAD_TR                  = 24 #  invalid ESYS_TR handle
TSS2_BASE_RC_MULTIPLE_DECRYPT_SESSIONS = 25 #  More than one session with TPMA_SESSION_DECRYPT bit set
TSS2_BASE_RC_MULTIPLE_ENCRYPT_SESSIONS = 26 #  More than one session with TPMA_SESSION_ENCRYPT bit set
TSS2_BASE_RC_RSP_AUTH_FAILED         = 27 #  Response HMAC from TPM did not verify
TSS2_BASE_RC_NO_CONFIG               = 28
TSS2_BASE_RC_BAD_PATH                = 29
TSS2_BASE_RC_NOT_DELETABLE           = 30
TSS2_BASE_RC_PATH_ALREADY_EXISTS     = 31
TSS2_BASE_RC_KEY_NOT_FOUND           = 32
TSS2_BASE_RC_SIGNATURE_VERIFICATION_FAILED = 33
TSS2_BASE_RC_HASH_MISMATCH           = 34
TSS2_BASE_RC_KEY_NOT_DUPLICABLE      = 35
TSS2_BASE_RC_PATH_NOT_FOUND          = 36
TSS2_BASE_RC_NO_CERT                 = 37
TSS2_BASE_RC_NO_PCR                  = 38
TSS2_BASE_RC_PCR_NOT_RESETTABLE      = 39
TSS2_BASE_RC_BAD_TEMPLATE            = 40
TSS2_BASE_RC_AUTHORIZATION_FAILED    = 41
TSS2_BASE_RC_AUTHORIZATION_UNKNOWN   = 42
TSS2_BASE_RC_NV_NOT_READABLE         = 43
TSS2_BASE_RC_NV_TOO_SMALL            = 44
TSS2_BASE_RC_NV_NOT_WRITEABLE        = 45
TSS2_BASE_RC_POLICY_UNKNOWN          = 46
TSS2_BASE_RC_NV_WRONG_TYPE           = 47
TSS2_BASE_RC_NAME_ALREADY_EXISTS     = 48
TSS2_BASE_RC_NO_TPM                  = 49
TSS2_BASE_RC_BAD_KEY                 = 50
TSS2_BASE_RC_NO_HANDLE               = 51
TSS2_BASE_RC_NOT_PROVISIONED         = 52
TSS2_BASE_RC_ALREADY_PROVISIONED     = 53

# Base return codes in the range 0xf800 - 0xffff are reserved for
# implementation-specific purposes.
TSS2_LAYER_IMPLEMENTATION_SPECIFIC_OFFSET = 0xf800
TSS2_LEVEL_IMPLEMENTATION_SPECIFIC_SHIFT = 11

# Success is the same for all software layers
TSS2_RC_SUCCESS = <TSS2_RC>0

# TCTI error codes
#TSS2_TCTI_RC_GENERAL_FAILURE          = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                            TSS2_BASE_RC_GENERAL_FAILURE))
#TSS2_TCTI_RC_NOT_IMPLEMENTED          = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                            TSS2_BASE_RC_NOT_IMPLEMENTED))
#TSS2_TCTI_RC_BAD_CONTEXT              = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_BAD_CONTEXT))
#TSS2_TCTI_RC_ABI_MISMATCH             = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_ABI_MISMATCH))
#TSS2_TCTI_RC_BAD_REFERENCE            = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_BAD_REFERENCE))
#TSS2_TCTI_RC_INSUFFICIENT_BUFFER      = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_INSUFFICIENT_BUFFER))
#TSS2_TCTI_RC_BAD_SEQUENCE             = (<TSS2_RC>(TSS2_TCTI_RC_LAYER |  \
#                                             TSS2_BASE_RC_BAD_SEQUENCE))
#TSS2_TCTI_RC_NO_CONNECTION            = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_NO_CONNECTION))
#TSS2_TCTI_RC_TRY_AGAIN                = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_TRY_AGAIN))
#TSS2_TCTI_RC_IO_ERROR                 = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_IO_ERROR))
#TSS2_TCTI_RC_BAD_VALUE                = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_BAD_VALUE))
#TSS2_TCTI_RC_NOT_PERMITTED            = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_NOT_PERMITTED))
#TSS2_TCTI_RC_MALFORMED_RESPONSE       = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_MALFORMED_RESPONSE))
#TSS2_TCTI_RC_NOT_SUPPORTED            = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_NOT_SUPPORTED))
#TSS2_TCTI_RC_MEMORY                   = (<TSS2_RC>(TSS2_TCTI_RC_LAYER | \
#                                             TSS2_BASE_RC_MEMORY))
## SAPI error codes
#TSS2_SYS_RC_GENERAL_FAILURE           = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                            TSS2_BASE_RC_GENERAL_FAILURE))
#TSS2_SYS_RC_ABI_MISMATCH              = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_ABI_MISMATCH))
#TSS2_SYS_RC_BAD_REFERENCE             = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_BAD_REFERENCE))
#TSS2_SYS_RC_INSUFFICIENT_BUFFER       = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_INSUFFICIENT_BUFFER))
#TSS2_SYS_RC_BAD_SEQUENCE              = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_BAD_SEQUENCE))
#TSS2_SYS_RC_BAD_VALUE                 = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_BAD_VALUE))
#TSS2_SYS_RC_INVALID_SESSIONS          = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_INVALID_SESSIONS))
#TSS2_SYS_RC_NO_DECRYPT_PARAM          = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_NO_DECRYPT_PARAM))
#TSS2_SYS_RC_NO_ENCRYPT_PARAM          = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_NO_ENCRYPT_PARAM))
#TSS2_SYS_RC_BAD_SIZE                  = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_BAD_SIZE))
#TSS2_SYS_RC_MALFORMED_RESPONSE        = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_MALFORMED_RESPONSE))
#TSS2_SYS_RC_INSUFFICIENT_CONTEXT      = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_INSUFFICIENT_CONTEXT))
#TSS2_SYS_RC_INSUFFICIENT_RESPONSE     = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_INSUFFICIENT_RESPONSE))
#TSS2_SYS_RC_INCOMPATIBLE_TCTI         = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_INCOMPATIBLE_TCTI))
#TSS2_SYS_RC_BAD_TCTI_STRUCTURE        = (<TSS2_RC>(TSS2_SYS_RC_LAYER | \
#                                             TSS2_BASE_RC_BAD_TCTI_STRUCTURE))
#
## MUAPI error codes
#TSS2_MU_RC_GENERAL_FAILURE            = (<TSS2_RC>(TSS2_MU_RC_LAYER | \
#                                             TSS2_BASE_RC_GENERAL_FAILURE))
#TSS2_MU_RC_BAD_REFERENCE              = (<TSS2_RC>(TSS2_MU_RC_LAYER | \
#                                             TSS2_BASE_RC_BAD_REFERENCE))
#TSS2_MU_RC_BAD_SIZE                   = (<TSS2_RC>(TSS2_MU_RC_LAYER | \
#                                             TSS2_BASE_RC_BAD_SIZE))
#TSS2_MU_RC_BAD_VALUE                  = (<TSS2_RC>(TSS2_MU_RC_LAYER | \
#                                             TSS2_BASE_RC_BAD_VALUE))
#TSS2_MU_RC_INSUFFICIENT_BUFFER        = (<TSS2_RC>(TSS2_MU_RC_LAYER | \
#                                             TSS2_BASE_RC_INSUFFICIENT_BUFFER))
#
## ESAPI Error Codes
#TSS2_ESYS_RC_GENERAL_FAILURE           = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_GENERAL_FAILURE))
#TSS2_ESYS_RC_NOT_IMPLEMENTED           = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_NOT_IMPLEMENTED))
#TSS2_ESYS_RC_ABI_MISMATCH              = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_ABI_MISMATCH))
#TSS2_ESYS_RC_BAD_REFERENCE             = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_BAD_REFERENCE))
#TSS2_ESYS_RC_INSUFFICIENT_BUFFER       = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_INSUFFICIENT_BUFFER))
#TSS2_ESYS_RC_BAD_SEQUENCE              = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_BAD_SEQUENCE))
#TSS2_ESYS_RC_INVALID_SESSIONS          = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_INVALID_SESSIONS))
#TSS2_ESYS_RC_TRY_AGAIN                 = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_TRY_AGAIN))
#TSS2_ESYS_RC_IO_ERROR                  = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_IO_ERROR))
#TSS2_ESYS_RC_BAD_VALUE                 = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_BAD_VALUE))
#TSS2_ESYS_RC_NO_DECRYPT_PARAM          = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_NO_DECRYPT_PARAM))
#TSS2_ESYS_RC_NO_ENCRYPT_PARAM          = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_NO_ENCRYPT_PARAM))
#TSS2_ESYS_RC_BAD_SIZE                  = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_BAD_SIZE))
#TSS2_ESYS_RC_MALFORMED_RESPONSE        = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_MALFORMED_RESPONSE))
#TSS2_ESYS_RC_INSUFFICIENT_CONTEXT      = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_INSUFFICIENT_CONTEXT))
#TSS2_ESYS_RC_INSUFFICIENT_RESPONSE     = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_INSUFFICIENT_RESPONSE))
#TSS2_ESYS_RC_INCOMPATIBLE_TCTI         = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_INCOMPATIBLE_TCTI))
#TSS2_ESYS_RC_BAD_TCTI_STRUCTURE        = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_BAD_TCTI_STRUCTURE))
#TSS2_ESYS_RC_MEMORY                    = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                              TSS2_BASE_RC_MEMORY))
#TSS2_ESYS_RC_BAD_TR                    = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                                TSS2_BASE_RC_BAD_TR))
#TSS2_ESYS_RC_MULTIPLE_DECRYPT_SESSIONS = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                                TSS2_BASE_RC_MULTIPLE_DECRYPT_SESSIONS))
#TSS2_ESYS_RC_MULTIPLE_ENCRYPT_SESSIONS = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                                TSS2_BASE_RC_MULTIPLE_ENCRYPT_SESSIONS))
#TSS2_ESYS_RC_RSP_AUTH_FAILED           = (<TSS2_RC>(TSS2_ESAPI_RC_LAYER | \
#                                                TSS2_BASE_RC_RSP_AUTH_FAILED))
#
## FAPI Error Codes
#TSS2_FAPI_RC_GENERAL_FAILURE           = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                              TSS2_BASE_RC_GENERAL_FAILURE))
#TSS2_FAPI_RC_NOT_IMPLEMENTED           = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                              TSS2_BASE_RC_NOT_IMPLEMENTED))
#TSS2_FAPI_RC_BAD_REFERENCE             = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                              TSS2_BASE_RC_BAD_REFERENCE))
#TSS2_FAPI_RC_BAD_SEQUENCE              = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                              TSS2_BASE_RC_BAD_SEQUENCE))
#TSS2_FAPI_RC_IO_ERROR                  = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                              TSS2_BASE_RC_IO_ERROR))
#TSS2_FAPI_RC_BAD_VALUE                 = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                              TSS2_BASE_RC_BAD_VALUE))
#TSS2_FAPI_RC_NO_DECRYPT_PARAM          = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                              TSS2_BASE_RC_NO_DECRYPT_PARAM))
#TSS2_FAPI_RC_NO_ENCRYPT_PARAM          = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                              TSS2_BASE_RC_NO_ENCRYPT_PARAM))
#TSS2_FAPI_RC_MEMORY                    = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                              TSS2_BASE_RC_MEMORY))
#TSS2_FAPI_RC_BAD_CONTEXT               = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_BAD_CONTEXT))
#TSS2_FAPI_RC_NO_CONFIG                 = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NO_CONFIG))
#TSS2_FAPI_RC_BAD_PATH                  = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_BAD_PATH))
#TSS2_FAPI_RC_NOT_DELETABLE             = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NOT_DELETABLE))
#TSS2_FAPI_RC_PATH_ALREADY_EXISTS       = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_PATH_ALREADY_EXISTS))
#TSS2_FAPI_RC_KEY_NOT_FOUND             = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_KEY_NOT_FOUND))
#TSS2_FAPI_RC_SIGNATURE_VERIFICATION_FAILED = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_SIGNATURE_VERIFICATION_FAILED))
#TSS2_FAPI_RC_HASH_MISMATCH             = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_HASH_MISMATCH))
#TSS2_FAPI_RC_KEY_NOT_DUPLICABLE        = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_KEY_NOT_DUPLICABLE))
#TSS2_FAPI_RC_PATH_NOT_FOUND            = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_PATH_NOT_FOUND))
#TSS2_FAPI_RC_NO_CERT                   = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NO_CERT))
#TSS2_FAPI_RC_NO_PCR                    = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NO_PCR))
#TSS2_FAPI_RC_PCR_NOT_RESETTABLE        = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_PCR_NOT_RESETTABLE))
#TSS2_FAPI_RC_BAD_TEMPLATE              = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_BAD_TEMPLATE))
#TSS2_FAPI_RC_AUTHORIZATION_FAILED      = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_AUTHORIZATION_FAILED))
#TSS2_FAPI_RC_AUTHORIZATION_UNKNOWN     = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_AUTHORIZATION_UNKNOWN))
#TSS2_FAPI_RC_NV_NOT_READABLE           = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NV_NOT_READABLE))
#TSS2_FAPI_RC_NV_TOO_SMALL              = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NV_TOO_SMALL))
#TSS2_FAPI_RC_NV_NOT_WRITEABLE          = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NV_NOT_WRITEABLE))
#TSS2_FAPI_RC_POLICY_UNKNOWN            = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_POLICY_UNKNOWN))
#TSS2_FAPI_RC_NV_WRONG_TYPE             = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NV_WRONG_TYPE))
#TSS2_FAPI_RC_NAME_ALREADY_EXISTS       = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NAME_ALREADY_EXISTS))
#TSS2_FAPI_RC_NO_TPM                    = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NO_TPM))
#TSS2_FAPI_RC_TRY_AGAIN                 = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_TRY_AGAIN))
#TSS2_FAPI_RC_BAD_KEY                   = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_BAD_KEY))
#TSS2_FAPI_RC_NO_HANDLE                 = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NO_HANDLE))
#TSS2_FAPI_RC_NOT_PROVISIONED           = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_NOT_PROVISIONED))
#TSS2_FAPI_RC_ALREADY_PROVISIONED       = (<TSS2_RC>(TSS2_FEATURE_RC_LAYER | \
#                                                TSS2_BASE_RC_ALREADY_PROVISIONED))
