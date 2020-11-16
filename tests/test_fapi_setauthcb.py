import random
import hashlib
import contextlib

from tpm2_pytss.fapi_callbacks import *
from tpm2_pytss.fapi import FAPI, FAPIDefaultConfig
from tpm2_pytss.binding import *
from tpm2_pytss.util.testing import BaseTestFAPI

MSG = "Text to Sign"


def auth_cb(object_path, discription, auth, user_data):
    user_data[0].assertEqual(user_data[1], {"my": "data"})
    CHAR_PTR_PTR_assign(a, "123")  # Since auth is a char **, this assing should work
    return TSS2_RC_SUCCESS


class TestSetAuthCB(BaseTestFAPI):
    def test_setauthcb(self):
        self.fapi_ctx.Provision(None, None, None)

        # TODO Uncomment the following
        # self.fapi_ctx.SetAuthCB(auth_cb, None)
        my_set_callback((self.fapi_ctx.ctxp, auth_cb, (self, {"my": "data"}),))

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
