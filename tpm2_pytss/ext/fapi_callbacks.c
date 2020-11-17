#define PY_SSIZE_T_CLEAN
#include <Python.h>

#include <tss2/tss2_fapi.h>


static PyObject *FapiCallbacksError;

static PyObject *my_callback = NULL;

/* TODO make it so that we can support the folling type of syntax:

	from typing import Any

	def mycb(fapi_ctx (the python version of the fapi_ctx),
			 description: str,
			 auth: str,
			 userData: Any):

		auth_cb_ok: bool = False

		print(fapi_ctx, description, auth, userData)
		# Not sure what the body should be here either
		if some_check():
			auth_cb_ok = fapi_ctx.TSS2_RC_SUCCESS
		else:
			# Not sure here, pretty sure if failure it can be any non-success
			# error code
			auth_cb_ok = TSS2_BASE_RC_BAD_VALUE

		return auth_cb_ok


	myvars = {"feed": "face"}

	with fapi_ctx.SetAuthCB(mycb, myvars):
		fapi_ctx.something() ...

 * I've been mostly working off of this: https://docs.python.org/3/extending/extending.html
 *
 * I think what needs to be done is to overwride / wrap the SetAuthCB function
 * within binding.py or maybe util/swig.py in WrapperMetaClass so that we make
 * sure that if the SetAuthCB function is called, it instead calls this function
 * in this .c file.
 *
 * This function should take the Python function we want to call and the python
 * data we want to pass to it when it's called.
 *
 * We need to make another C function with the appropricate signature which we
 * will use as the real callback function. That function should take a struct
 * which contains a pointer to the Python funtion and the pointer to the Python
 * data that that functoin wants. We will use this new struct as the userData
 * for our C function. Our C function will call the python function and return
 * the result.
 */
TSS2_RC Fapi_CB_Auth_Proxy(
    FAPI_CONTEXT   *context,
    char     const *description,
    char          **auth,
    void           *userData)
{
    return TSS2_RC_SUCCESS;
}

static PyObject *
my_set_callback(PyObject *dummy, PyObject *args)
{
    // PyObject *result = NULL;
    // PyObject *temp;

    // if (PyArg_ParseTuple(args, "O:set_callback", &temp)) {
    //     if (!PyCallable_Check(temp)) {
    //         PyErr_SetString(PyExc_TypeError, "parameter must be callable");
    //         return NULL;
    //     }
    //     Py_XINCREF(temp);         /* Add a reference to new callback */
    //     Py_XDECREF(my_callback);  /* Dispose of previous callback */
    //     my_callback = temp;       /* Remember new callback */
    //     /* Boilerplate to return "None" */
    //     Py_INCREF(Py_None);
    //     result = Py_None;
    // }

  PyObject *resultobj = 0;
  FAPI_CONTEXT *arg1 = (FAPI_CONTEXT *) 0 ;
  Fapi_CB_Auth arg2 = (Fapi_CB_Auth) 0 ;
  void *arg3 = (void *) 0 ;
  void *argp1 = 0 ;
  int res1 = 0 ;
  int res3 ;
  PyObject *swig_obj[3] ;
  TSS2_RC result;

  if (!SWIG_Python_UnpackTuple(args, "Fapi_SetAuthCB", 3, 3, swig_obj)) SWIG_fail;
  res1 = SWIG_ConvertPtr(swig_obj[0], &argp1,SWIGTYPE_p_FAPI_CONTEXT, 0 |  0 );
  if (!SWIG_IsOK(res1)) {
    SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "Fapi_SetAuthCB" "', argument " "1"" of type '" "FAPI_CONTEXT *""'"); 
  }
  arg1 = (FAPI_CONTEXT *)(argp1);
  {
    int res = SWIG_ConvertFunctionPtr(swig_obj[1], (void**)(&arg2), SWIGTYPE_p_f_p_struct_FAPI_CONTEXT_p_q_const__char_p_p_char_p_void__unsigned_int);
    if (!SWIG_IsOK(res)) {
      SWIG_exception_fail(SWIG_ArgError(res), "in method '" "Fapi_SetAuthCB" "', argument " "2"" of type '" "Fapi_CB_Auth""'"); 
    }
  }
  res3 = SWIG_ConvertPtr(swig_obj[2],SWIG_as_voidptrptr(&arg3), 0, 0);
  if (!SWIG_IsOK(res3)) {
    SWIG_exception_fail(SWIG_ArgError(res3), "in method '" "Fapi_SetAuthCB" "', argument " "3"" of type '" "void *""'"); 
  }
  result = (TSS2_RC)Fapi_SetAuthCB(arg1,arg2,arg3);
  resultobj = SWIG_From_unsigned_SS_int((unsigned int)(result));
  return resultobj;


    printf("\n\n\nmy_set_callback\n\n\n\n");
    if (Fapi_SetAuthCB(Fapi_CB_Auth_Proxy, (void *)temp)) {
        PyErr_SetString(PyExc_TypeError, "TPM2Error: Failure to set auth callback");
        return NULL;
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
    {"my_set_callback",  my_set_callback, METH_VARARGS,
     "Callback setter"},
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
