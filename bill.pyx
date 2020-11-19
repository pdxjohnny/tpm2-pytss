from libc.stdio cimport printf
from cpython.int cimport (PyInt_AsLong, PyInt_Check)
from cpython.ref cimport (PyObject, Py_DECREF)
from cpython.object cimport PyObject_CallMethod

cdef class BILL(object):
    cdef void *__bill;

    def __init__(self):
        self.__bill = bill_new()

    def setcb(self, obj):
        wrap_bill_set_callback(self.__bill, obj)

    def __call__(self):
        return bill_invoke_callback(self.__bill)

ctypedef int (*pfn)(void *userdata)
cdef extern void *bill_new()
cdef extern void bill_set_callback(void *b, pfn callback, void *udata)
cdef extern int bill_invoke_callback(void *b)

cdef int callback_handler(void *_pyObj) with gil:
    # TODO invoke PyObj
    cdef int rc
    cdef object pyObj = <object>_pyObj
    cdef object rcObj = None
    printf("Callback handler: %p\n", _pyObj)
    # An empty tuple for format means no arguments
    rcObj = PyObject_CallMethod(pyObj, "__call__", "()")
    assert(PyInt_Check(rcObj) == 1)
    rc = <int>PyInt_AsLong(rcObj)
    Py_DECREF(rcObj)
    return rc

cdef void wrap_bill_set_callback(void *b, object obj):
    # What kind of pointer is this? A PyObject *?
    # TODO Reference counting?
    bill_set_callback(b, callback_handler, <void *>obj)
