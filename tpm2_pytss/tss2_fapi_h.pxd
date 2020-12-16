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

from tss2_tcti_h cimport (
    TSS2_TCTI_CONTEXT,
)


cdef extern from "<tss2/tss2_fapi.h>":
    struct FAPI_CONTEXT:
        pass

    TSS2_RC Fapi_Initialize(FAPI_CONTEXT **context, const char *uri)

    TSS2_RC Fapi_Initialize_Async(FAPI_CONTEXT **context, const char *uri)

    TSS2_RC Fapi_Initialize_Finish(FAPI_CONTEXT **context)

    void Fapi_Finalize(FAPI_CONTEXT **context)

    TSS2_RC Fapi_GetTcti(FAPI_CONTEXT *context, TSS2_TCTI_CONTEXT **tcti)

    void Fapi_Free(void *ptr)

    ctypedef pollfd pollfd

    TSS2_RC Fapi_GetPollHandles(FAPI_CONTEXT *context, FAPI_POLL_HANDLE **handles, size_t *num_handles)

    TSS2_RC Fapi_GetInfo(FAPI_CONTEXT *context, char **info)

    TSS2_RC Fapi_GetInfo_Async(FAPI_CONTEXT *context)

    TSS2_RC Fapi_GetInfo_Finish(FAPI_CONTEXT *context, char **info)

    TSS2_RC Fapi_Provision(FAPI_CONTEXT *context, const char *authValueEh, const char *authValueSh, const char *authValueLockout)

    TSS2_RC Fapi_Provision_Async(FAPI_CONTEXT *context, const char *authValueEh, const char *authValueSh, const char *authValueLockout)

    TSS2_RC Fapi_Provision_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_GetPlatformCertificates(FAPI_CONTEXT *context, uint8_t **certificates, size_t *certificatesSize)

    TSS2_RC Fapi_GetPlatformCertificates_Async(FAPI_CONTEXT *context)

    TSS2_RC Fapi_GetPlatformCertificates_Finish(FAPI_CONTEXT *context, uint8_t **certificates, size_t *certificatesSize)

    TSS2_RC Fapi_GetRandom(FAPI_CONTEXT *context, size_t numBytes, uint8_t **data)

    TSS2_RC Fapi_GetRandom_Async(FAPI_CONTEXT *context, size_t numBytes)

    TSS2_RC Fapi_GetRandom_Finish(FAPI_CONTEXT *context, uint8_t **data)

    TSS2_RC Fapi_Import(FAPI_CONTEXT *context, const char *path, const char *importData)

    TSS2_RC Fapi_Import_Async(FAPI_CONTEXT *context, const char *path, const char *importData)

    TSS2_RC Fapi_Import_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_List(FAPI_CONTEXT *context, const char *searchPath, char **pathList)

    TSS2_RC Fapi_List_Async(FAPI_CONTEXT *context, const char *searchPath)

    TSS2_RC Fapi_List_Finish(FAPI_CONTEXT *context, char **pathList)

    TSS2_RC Fapi_Delete(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_Delete_Async(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_Delete_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_GetEsysBlob(FAPI_CONTEXT *context, const char *path, uint8_t *type, uint8_t **data, size_t *length)

    TSS2_RC Fapi_GetEsysBlob_Async(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_GetEsysBlob_Finish(FAPI_CONTEXT *context, uint8_t *type, uint8_t **data, size_t *length)

    TSS2_RC Fapi_ChangeAuth(FAPI_CONTEXT *context, const char *entityPath, const char *authValue)

    TSS2_RC Fapi_ChangeAuth_Async(FAPI_CONTEXT *context, const char *entityPath, const char *authValue)

    TSS2_RC Fapi_ChangeAuth_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_SetDescription(FAPI_CONTEXT *context, const char *path, const char *description)

    TSS2_RC Fapi_SetDescription_Async(FAPI_CONTEXT *context, const char *path, const char *description)

    TSS2_RC Fapi_SetDescription_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_GetDescription(FAPI_CONTEXT *context, const char *path, char **description)

    TSS2_RC Fapi_GetDescription_Async(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_GetDescription_Finish(FAPI_CONTEXT *context, char **description)

    TSS2_RC Fapi_SetAppData(FAPI_CONTEXT *context, const char *path, const uint8_t *appData, size_t appDataSize)

    TSS2_RC Fapi_SetAppData_Async(FAPI_CONTEXT *context, const char *path, const uint8_t *appData, size_t appDataSize)

    TSS2_RC Fapi_SetAppData_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_GetAppData(FAPI_CONTEXT *context, const char *path, uint8_t **appData, size_t *appDataSize)

    TSS2_RC Fapi_GetAppData_Async(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_GetAppData_Finish(FAPI_CONTEXT *context, uint8_t **appData, size_t *appDataSize)

    TSS2_RC Fapi_GetTpmBlobs(FAPI_CONTEXT *context, const char *path, uint8_t **tpm2bPublic, size_t *tpm2bPublicSize, uint8_t **tpm2bPrivate, size_t *tpm2bPrivateSize, char **policy)

    TSS2_RC Fapi_GetTpmBlobs_Async(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_GetTpmBlobs_Finish(FAPI_CONTEXT *context, uint8_t **tpm2bPublic, size_t *tpm2bPublicSize, uint8_t **tpm2bPrivate, size_t *tpm2bPrivateSize, char **policy)

    TSS2_RC Fapi_CreateKey(FAPI_CONTEXT *context, const char *path, const char *type, const char *policyPath, const char *authValue)

    TSS2_RC Fapi_CreateKey_Async(FAPI_CONTEXT *context, const char *path, const char *type, const char *policyPath, const char *authValue)

    TSS2_RC Fapi_CreateKey_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_Sign(FAPI_CONTEXT *context, const char *keyPath, const char *padding, const uint8_t *digest, size_t digestSize, uint8_t **signature, size_t *signatureSize, char **publicKey, char **certificate)

    TSS2_RC Fapi_Sign_Async(FAPI_CONTEXT *context, const char *keyPath, const char *padding, const uint8_t *digest, size_t digestSize)

    TSS2_RC Fapi_Sign_Finish(FAPI_CONTEXT *context, uint8_t **signature, size_t *signatureSize, char **publicKey, char **certificate)

    TSS2_RC Fapi_VerifySignature(FAPI_CONTEXT *context, const char *keyPath, const uint8_t *digest, size_t digestSize, const uint8_t *signature, size_t signatureSize)

    TSS2_RC Fapi_VerifySignature_Async(FAPI_CONTEXT *context, const char *keyPath, const uint8_t *digest, size_t digestSize, const uint8_t *signature, size_t signatureSize)

    TSS2_RC Fapi_VerifySignature_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_Encrypt(FAPI_CONTEXT *context, const char *keyPath, const uint8_t *plainText, size_t plainTextSize, uint8_t **cipherText, size_t *cipherTextSize)

    TSS2_RC Fapi_Encrypt_Async(FAPI_CONTEXT *context, const char *keyPath, const uint8_t *plainText, size_t plainTextSize)

    TSS2_RC Fapi_Encrypt_Finish(FAPI_CONTEXT *context, uint8_t **cipherText, size_t *cipherTextSize)

    TSS2_RC Fapi_Decrypt(FAPI_CONTEXT *context, const char *keyPath, const uint8_t *cipherText, size_t cipherTextSize, uint8_t **plainText, size_t *plainTextSize)

    TSS2_RC Fapi_Decrypt_Async(FAPI_CONTEXT *context, const char *keyPath, const uint8_t *cipherText, size_t cipherTextSize)

    TSS2_RC Fapi_Decrypt_Finish(FAPI_CONTEXT *context, uint8_t **plainText, size_t *plainTextSize)

    TSS2_RC Fapi_SetCertificate(FAPI_CONTEXT *context, const char *path, const char *x509certData)

    TSS2_RC Fapi_SetCertificate_Async(FAPI_CONTEXT *context, const char *path, const char *x509certData)

    TSS2_RC Fapi_SetCertificate_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_GetCertificate(FAPI_CONTEXT *context, const char *path, char **x509certData)

    TSS2_RC Fapi_GetCertificate_Async(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_GetCertificate_Finish(FAPI_CONTEXT *context, char **x509certData)

    TSS2_RC Fapi_ExportKey(FAPI_CONTEXT *context, const char *pathOfKeyToDuplicate, const char *pathToPublicKeyOfNewParent, char **exportedData)

    TSS2_RC Fapi_ExportKey_Async(FAPI_CONTEXT *context, const char *pathOfKeyToDuplicate, const char *pathToPublicKeyOfNewParent)

    TSS2_RC Fapi_ExportKey_Finish(FAPI_CONTEXT *context, char **exportedData)

    TSS2_RC Fapi_CreateSeal(FAPI_CONTEXT *context, const char *path, const char *type, size_t size, const char *policyPath, const char *authValue, const uint8_t *data)

    TSS2_RC Fapi_CreateSeal_Async(FAPI_CONTEXT *context, const char *path, const char *type, size_t size, const char *policyPath, const char *authValue, const uint8_t *data)

    TSS2_RC Fapi_CreateSeal_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_Unseal(FAPI_CONTEXT *context, const char *path, uint8_t **data, size_t *size)

    TSS2_RC Fapi_Unseal_Async(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_Unseal_Finish(FAPI_CONTEXT *context, uint8_t **data, size_t *size)

    TSS2_RC Fapi_ExportPolicy(FAPI_CONTEXT *context, const char *path, char **jsonPolicy)

    TSS2_RC Fapi_ExportPolicy_Async(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_ExportPolicy_Finish(FAPI_CONTEXT *context, char **jsonPolicy)

    TSS2_RC Fapi_AuthorizePolicy(FAPI_CONTEXT *context, const char *policyPath, const char *keyPath, const uint8_t *policyRef, size_t policyRefSize)

    TSS2_RC Fapi_AuthorizePolicy_Async(FAPI_CONTEXT *context, const char *policyPath, const char *keyPath, const uint8_t *policyRef, size_t policyRefSize)

    TSS2_RC Fapi_AuthorizePolicy_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_WriteAuthorizeNv(FAPI_CONTEXT *context, const char *nvPath, const char *policyPath)

    TSS2_RC Fapi_WriteAuthorizeNv_Async(FAPI_CONTEXT *context, const char *nvPath, const char *policyPath)

    TSS2_RC Fapi_WriteAuthorizeNv_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_PcrRead(FAPI_CONTEXT *context, uint32_t pcrIndex, uint8_t **pcrValue, size_t *pcrValueSize, char **pcrLog)

    TSS2_RC Fapi_PcrRead_Async(FAPI_CONTEXT *context, uint32_t pcrIndex)

    TSS2_RC Fapi_PcrRead_Finish(FAPI_CONTEXT *context, uint8_t **pcrValue, size_t *pcrValueSize, char **pcrLog)

    TSS2_RC Fapi_PcrExtend(FAPI_CONTEXT *context, uint32_t pcr, const uint8_t *data, size_t dataSize, const char *logData)

    TSS2_RC Fapi_PcrExtend_Async(FAPI_CONTEXT *context, uint32_t pcr, const uint8_t *data, size_t dataSize, const char *logData)

    TSS2_RC Fapi_PcrExtend_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_Quote(FAPI_CONTEXT *context, uint32_t *pcrList, size_t pcrListSize, const char *keyPath, const char *quoteType, const uint8_t *qualifyingData, size_t qualifyingDataSize, char **quoteInfo, uint8_t **signature, size_t *signatureSize, char **pcrLog, char **certificate)

    TSS2_RC Fapi_Quote_Async(FAPI_CONTEXT *context, uint32_t *pcrList, size_t pcrListSize, const char *keyPath, const char *quoteType, const uint8_t *qualifyingData, size_t qualifyingDataSize)

    TSS2_RC Fapi_Quote_Finish(FAPI_CONTEXT *context, char **quoteInfo, uint8_t **signature, size_t *signatureSize, char **pcrLog, char **certificate)

    TSS2_RC Fapi_VerifyQuote(FAPI_CONTEXT *context, const char *publicKeyPath, const uint8_t *qualifyingData, size_t qualifyingDataSize, const char *quoteInfo, const uint8_t *signature, size_t signatureSize, const char *pcrLog)

    TSS2_RC Fapi_VerifyQuote_Async(FAPI_CONTEXT *context, const char *publicKeyPath, const uint8_t *qualifyingData, size_t qualifyingDataSize, const char *quoteInfo, const uint8_t *signature, size_t signatureSize, const char *pcrLog)

    TSS2_RC Fapi_VerifyQuote_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_CreateNv(FAPI_CONTEXT *context, const char *path, const char *type, size_t size, const char *policyPath, const char *authValue)

    TSS2_RC Fapi_CreateNv_Async(FAPI_CONTEXT *context, const char *path, const char *type, size_t size, const char *policyPath, const char *authValue)

    TSS2_RC Fapi_CreateNv_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_NvRead(FAPI_CONTEXT *context, const char *path, uint8_t **data, size_t *size, char **logData)

    TSS2_RC Fapi_NvRead_Async(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_NvRead_Finish(FAPI_CONTEXT *context, uint8_t **data, size_t *size, char **logData)

    TSS2_RC Fapi_NvWrite(FAPI_CONTEXT *context, const char *path, const uint8_t *data, size_t size)

    TSS2_RC Fapi_NvWrite_Async(FAPI_CONTEXT *context, const char *path, const uint8_t *data, size_t size)

    TSS2_RC Fapi_NvWrite_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_NvExtend(FAPI_CONTEXT *context, const char *path, const uint8_t *data, size_t size, const char *logData)

    TSS2_RC Fapi_NvExtend_Async(FAPI_CONTEXT *context, const char *path, const uint8_t *data, size_t size, const char *logData)

    TSS2_RC Fapi_NvExtend_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_NvIncrement(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_NvIncrement_Async(FAPI_CONTEXT *context, const char *path)

    TSS2_RC Fapi_NvIncrement_Finish(FAPI_CONTEXT *context)

    TSS2_RC Fapi_NvSetBits(FAPI_CONTEXT *context, const char *path, uint64_t bitmap)

    TSS2_RC Fapi_NvSetBits_Async(FAPI_CONTEXT *context, const char *path, uint64_t bitmap)

    TSS2_RC Fapi_NvSetBits_Finish(FAPI_CONTEXT *context)

    typedef TSS2_RC (*Fapi_CB_Auth)(const char *objectPath, const char *description, const char **auth, void *userData)

    TSS2_RC Fapi_SetAuthCB(FAPI_CONTEXT *context, Fapi_CB_Auth callback, void *userData)

    typedef TSS2_RC (*Fapi_CB_Branch)(const char *objectPath, const char *description, const char **branchNames, size_t numBranches, size_t *selectedBranch, void *userData)

    TSS2_RC Fapi_SetBranchCB(FAPI_CONTEXT *context, Fapi_CB_Branch callback, void *userData)

    typedef TSS2_RC (*Fapi_CB_Sign)(const char *objectPath, const char *description, const char *publicKey, const char *publicKeyHint, uint32_t hashAlg, const uint8_t *dataToSign, size_t dataToSignSize, const uint8_t **signature, size_t *signatureSize, void *userData)

    TSS2_RC Fapi_SetSignCB(FAPI_CONTEXT *context, Fapi_CB_Sign callback, void *userData)

    typedef TSS2_RC (*Fapi_CB_PolicyAction)(const char *objectPath, const char *action, void *userData)

    TSS2_RC Fapi_SetPolicyActionCB(FAPI_CONTEXT *context, Fapi_CB_PolicyAction callback, void *userData)

