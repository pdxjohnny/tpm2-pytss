#!/usr/bin/env python

import binascii
from pyesys import *

def fn():
    print("I ain't no hollerback girl")

ectx = EsysContext()
x = ectx.rand(5)
print(type(x))
print ("len: {}".format(len(x)))
print (binascii.hexlify(x))
