import random
from contextlib import ExitStack

# import unittest
# from tpm2_pytss.fapi_binding import *

from tpm2_pytss.binding import *
from tpm2_pytss.util.testing import BaseTestFAPI


class TestGetRandom(BaseTestFAPI):
    # class TestGetRandom(unittest.TestCase):
    def test_mtype(self):
        return
        print()
        print()
        print()
        # print(mtype())
        m = mtype_class()
        print(m)
        print(m.assign(empty=1))
        print()
        mp = mtype_ptr_class()
        print(mp)
        print()

    def test_get_info(self):
        self.fapi_ctx.Provision(None, None, None)

        with CHAR_PTR_PTR() as array:
            print(self.fapi_ctx.GetInfo(array))

    def test_random_length(self):
        length = random.randint(8, 32)

        self.fapi_ctx.Provision(None, None, None)

        with UINT8_PTR_PTR() as array:
            array = self.fapi_ctx.GetRandom(length, array)

            value = to_bytearray(length, array)

            self.assertEqual(length, len(value))
