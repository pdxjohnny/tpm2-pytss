#!/usr/bin/env python

import binascii
from pyesys import *

ectx = EsysContext()
x = ectx.rand(5)
print(type(x))
print ("len: {}".format(len(x)))
print (binascii.hexlify(x))
