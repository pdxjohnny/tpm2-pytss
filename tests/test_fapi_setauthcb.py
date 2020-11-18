import random
import hashlib
import traceback
import contextlib

from tpm2_pytss.fapi import FAPI, FAPIDefaultConfig
from tpm2_pytss.binding import *
from tpm2_pytss.util.testing import BaseTestFAPI
from tpm2_pytss.fapi_callbacks import *

MSG = "Text to Sign"


PASSWORD = "abc"


class PyCallback(Fapi_Callback_Proxy):
    def __init__(self):
        Fapi_Callback_Proxy.__init__(self)

    def _Fapi_CB_Auth(self, object_path, discription, auth):
        print(repr([self, object_path, discription, auth]))
        if object_path != "P_RSA/HS/SRK/mySignKey":
            print("TSS2_FAPI_RC_BAD_VALUE: Unexpected path")
            # TODO Add TSS2_FAPI_RC_BAD_VALUE to tpm2_types
            # return FAPI.MODULE.TSS2_FAPI_RC_BAD_VALUE

        CHAR_PTR_PTR_assign(auth, PASSWORD)
        # result = TSS2_RC_PTR(TSS2_RC_SUCCESS)
        return TSS2_RC_SUCCESS

    def Fapi_CB_Auth(self, object_path, discription, auth):
        result = TPM2_RC_PTR()
        result.value = FAPI.MODULE.TPM2_RC_FAILURE
        try:
            result.value = self._Fapi_CB_Auth(object_path, discription, auth)
        except:
            traceback.print_exc()
        print()
        print(result)
        print(result.value)
        print()
        return result.value


"""
static TSS2_RC
auth_callback(
    char const *objectPath,
    char const *description,
    const char **auth,
    void *userData)
{
    (void)description;
    (void)userData;

    if (strcmp(objectPath, "P_RSA/HS/SRK/mySignKey") != 0) {
        return_error(TSS2_FAPI_RC_BAD_VALUE, "Unexpected path");
    }

    *auth = PASSWORD;
    return TSS2_RC_SUCCESS;
}
"""

# ifdef FAPI_DA
# define SIGN_TEMPLATE  "sign"
# else
# define SIGN_TEMPLATE  "sign, noDa"
# endif
SIGN_TEMPLATE = "sign"

# Test the FAPI functions for key creation and usage with noda and da flag.
#
# Tested FAPI commands:
#  - Fapi_Provision()
#  - Fapi_CreateKey()
#  - Fapi_SetAuthCB()
#  - Fapi_Sign()
#  - Fapi_Delete()
#
# @param[in,out] context The FAPI_CONTEXT.
# @retval EXIT_FAILURE
# @retval EXIT_SUCCESS


class TestSetAuthCB(BaseTestFAPI):
    def test_setauthcb(self):
        # Create an Caller instance
        caller = Caller()
        # caller.delCallback()

        self.fapi_ctx.Provision(None, None, None)

        self.fapi_ctx.CreateKey("HS/SRK/mySignKey", SIGN_TEMPLATE, "", PASSWORD)

        self.fapi_ctx.SetCertificate(
            "HS/SRK/mySignKey",
            "-----BEGIN CERTIFICATE-----[...]-----END CERTIFICATE-----",
        )

        signatureSize = 0

        digest = TPM2B_DIGEST(
            size=20,
            buffer=[
                0x67,
                0x68,
                0x03,
                0x3E,
                0x21,
                0x64,
                0x68,
                0x24,
                0x7B,
                0xD0,
                0x31,
                0xA0,
                0xA2,
                0xD9,
                0x87,
                0x6D,
                0x79,
                0x81,
                0x8F,
                0x8F,
            ],
        )

        callback = PyCallback().__disown__()
        caller.setCallback(callback)
        caller.SetAuthCB_Fapi(self.fapi_ctx.ctxp)
        # self.fapi_ctx.SetAuthCB(caller.Fapi_CB_Auth_Proxy, caller)
        # self.fapi_ctx.SetAuthCB(auth_callback, "")
        # print(Fapi_CB_Auth, Fapi_CB_Auth_Proxy)
        # self.fapi_ctx.SetAuthCB(Fapi_CB_Auth_Proxy, caller)

        signature, signatureSize, publicKey, certificate = self.fapi_ctx.Sign(
            "HS/SRK/mySignKey", None, digest.buffer, digest.size
        )
        self.assertTrue(signature.ptr)
        self.assertTrue(publicKey.ptr)
        self.assertTrue(certificate.ptr)
        self.assertGreater(len(publicKey), ASSERT_SIZE)
        self.assertGreater(len(certificate), ASSERT_SIZE)

        self.fapi_ctx.Delete("/")

    def old_code(self):
        # (pdxjohnny) Not sure where this came from
        self.fapi_ctx.Provision(None, None, None)

        # TODO Uncomment the following
        self.fapi_ctx.SetAuthCB(Fapi_CB_Auth_Proxy, (auth_cb, (self, {"my": "data"},)))
        # my_set_callback((self.fapi_ctx.ctxp, auth_cb, (self, {"my": "data"}),))

        # Key HS/SRK was created during provisioning
        #   self.fapi_ctx.Provision(None, None, None)
        #   self.fapi_ctx.CreateKey("HS/SRK/mysignkey", "sign", None, "123")

        hasher = hashlib.sha256()
        hasher.update(MSG.encode())
        digest = hasher.digest()
        digest_size = len(digest)

        digest_array = ByteArray(digest_size)
        for i, x in enumerate(digest):
            digest_array[i] = x
        digest_array_ptr = digest_array.cast()

        (
            sign_ptr_ptr_ctx,
            sign_size_ptr_ctx,
            pubkey_ptr_ptr_ctx,
            _,
        ) = self.fapi_ctx.Sign(
            "HS/SRK/mysignkey", "RSA_SSA", digest_array_ptr, digest_size,
        )

        sign = to_bytearray(sign_size_ptr_ctx, sign_ptr_ptr_ctx)
        pubkey = to_bytearray(len(pubkey_ptr_ptr_ctx), pubkey_ptr_ptr_ctx)
