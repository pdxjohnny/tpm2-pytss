import random
from contextlib import ExitStack

from tpm2_pytss.binding import *
from tpm2_pytss.util.testing import BaseTestFAPI


class TestGetRandom(BaseTestFAPI):
    def test_random_length(self):
        length = random.randint(8, 32)

        self.fapi_ctx.Provision(None, None, None)

        array = UINT8_PTR_PTR()

        with array:
            array = self.fapi_ctx.GetRandom(length, array)

            value = to_bytearray(length, array)

            self.assertEqual(length, len(value))
