#define PY_SSIZE_T_CLEAN
#include <Python.h>

static PyObject *FapiCallbacksError;

static PyObject *my_callback = NULL;

static PyObject *
my_set_callback(PyObject *dummy, PyObject *args)
{
    PyObject *result = NULL;
    PyObject *temp;

    if (PyArg_ParseTuple(args, "O:set_callback", &temp)) {
        if (!PyCallable_Check(temp)) {
            PyErr_SetString(PyExc_TypeError, "parameter must be callable");
            return NULL;
        }
        Py_XINCREF(temp);         /* Add a reference to new callback */
        Py_XDECREF(my_callback);  /* Dispose of previous callback */
        my_callback = temp;       /* Remember new callback */
        /* Boilerplate to return "None" */
        Py_INCREF(Py_None);
        result = Py_None;
    }
    return result;
}

static PyObject *
fapi_callbacks_system(PyObject *self, PyObject *args)
{
    const char *command;
    int sts;

    if (!PyArg_ParseTuple(args, "s", &command))
        return NULL;
    sts = system(command);
    if (sts < 0) {
        PyErr_SetString(FapiCallbacksError, "System command failed");
        return NULL;
    }
    return PyLong_FromLong(sts);
}

static PyMethodDef FapiCallbacksMethods[] = {
    {"system",  fapi_callbacks_system, METH_VARARGS,
     "Execute a shell command."},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef fapi_callbacks_module = {
    PyModuleDef_HEAD_INIT,
    "fapi_callbacks",   /* name of module */
    NULL,               /* module documentation, may be NULL */
    -1,                 /* size of per-interpreter state of the module, or -1
                           if the module keeps state in global variables. */
    FapiCallbacksMethods
};

PyMODINIT_FUNC
PyInit_fapi_callbacks(void)
{
    PyObject *m;

    m = PyModule_Create(&fapi_callbacks_module);
    if (m == NULL)
        return NULL;

    FapiCallbacksError = PyErr_NewException("fapi_callbacks.error", NULL, NULL);
    Py_XINCREF(FapiCallbacksError);
    if (PyModule_AddObject(m, "error", FapiCallbacksError) < 0) {
        Py_XDECREF(FapiCallbacksError);
        Py_CLEAR(FapiCallbacksError);
        Py_DECREF(m);
        return NULL;
    }

    return m;
}
