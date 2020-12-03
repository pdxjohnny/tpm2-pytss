import unittest

from tpm2_pytss.bill import *


class TestCallbacks(unittest.TestCase):
    def test_bill(self):
        return

        b = BILL()

        class MyCallback(object):
            def __call__(self):
                print("Bill YEAH")
                return 42

        b.setcb(MyCallback())
        x = b()
        print("Bill: 42 == {}".format(x))

        class MyCallback(object):
            def __call__(self):
                print("Bill2 YEAH")
                return 87

        c = BILL()
        c = BILL()
        c.setcb(MyCallback())
        x = c()
        print("Bill2: 87 == {}".format(x))
