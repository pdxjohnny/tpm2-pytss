import unittest
import binascii

from tpm2_pytss.pyesys import *


class TestEsys(unittest.TestCase):
    def test_rand(self):
        return
        ectx = EsysContext()
        x = ectx.rand(5)
        print(type(x))
        print("len: {}".format(len(x)))
        print(binascii.hexlify(x))
