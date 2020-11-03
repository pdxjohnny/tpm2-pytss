import os
import sys
import random
import asyncio
import tempfile
import unittest
import functools
import contextlib
from typing import *

# from tpm2_pytss.esys_binding import Tss2_TctiLdr_Initialize_Ex, tcti_ctx_ptr_ptr


import  tpm2_pytss.tcti_binding as tcti_binding
from tpm2_pytss.tcti_binding import Tss2_TctiLdr_Initialize_Ex
from tpm2_pytss.util.simulator import Simulator
from tpm2_pytss.util.retry import retry_tcti_loop, retry_tcti_catch, TCTI_RETRY_TRIES

ENV_TCTI = "PYESYS_TCTI"
ENV_TCTI_DEFAULT = "mssim"
ENV_TCTI_CONFIG = "PYESYS_TCTI_CONFIG"
ENV_TCTI_CONFIG_DEFAULT = None


class PointerClass:
    def __init__(self, value: Any = None) -> None:
        self.ptr = self._new()
        if value is not None:
            self.value = value

    def __del__(self):
        self._delete(self.ptr)
        self.ptr = None

    @property
    def value(self) -> Any:
        return self._value(self.ptr)

    @value.setter
    def value(self, value) -> None:
        self._assign(self.ptr, value)


def pointer_class(name, module):
    """
    Creates a class of the requested pointer functions data type
    which supports context management.
    """
    check = {
        "_new": "new_{}",
        "_copy": "copy_{}",
        "_delete": "delete_{}",
        "_assign": "{}_assign",
        "_value": "{}_value",
    }
    # Look up the methods
    for key, value in check.items():
        check[key] = module.__dict__.get(value.format(name), None)
    if not all(check.values()):
        return AttributeError
    # Ensure we don't pass self to the functions
    for key, value in check.items():
        check[key] = functools.partial(value)
    return type(name, (PointerClass,), check)


TSS2_TCTI_CONTEXT_PTR_PTR = pointer_class("tcti_ctx_ptr_ptr", tcti_binding)

class TestGetCapability(unittest.TestCase):
    def test_get_capability(self):
        print()
        # Create a context stack
        with contextlib.ExitStack() as ctx_stack:
            # Create a simulator
            self.simulator = ctx_stack.enter_context(Simulator())
            # Create the TCTI
            self.tcti_name = os.getenv(ENV_TCTI, default=ENV_TCTI_DEFAULT)
            self.tcti_config = os.getenv(
                ENV_TCTI_CONFIG, default="port=%d" % (self.simulator.port)
            )
            self.tcti_ctx = TSS2_TCTI_CONTEXT_PTR_PTR()
            print(self.tcti_ctx.value)
            # Attempt TCTI connection
            for retry in retry_tcti_loop(max_tries=TCTI_RETRY_TRIES):
                with retry_tcti_catch(retry):
                    rc = Tss2_TctiLdr_Initialize_Ex(
                        self.tcti_name, self.tcti_config, self.tcti_ctx.ptr
                    )

            print(self.tcti_ctx.value)



            return
            # Enter the contexts
            self.tcti_ctx = self.ctx_stack.enter_context(
                TCTI(name=self.tcti_name, config=self.tcti_config, retry=TCTI_RETRY_TRIES)
            )
            self.esys_ctx = self.ctx_stack.enter_context(self.esys(self.tcti_ctx))
            # Call Startup and clear the TPM
            self.Esys_Startup(self.esys_ctx.TPM2_SU_CLEAR)
            # Set the timeout to blocking
            self.Esys_SetTimeout(self.esys_ctx.TSS2_TCTI_TIMEOUT_BLOCK)

            # Call the function
            capability = TPM2_CAP_TPM_PROPERTIES
            prop = TPM2_PT_LOCKOUT_COUNTER
            propertyCount = 1

            # with TPMI_YES_NO_PTR(
            #     False
            # ) as moreData_ptr, TPMS_CAPABILITY_DATA_PTR_PTR() as capabilityData_ptr_ptr:

            moreData_ptr, capabilityData_ptr_ptr = self.esys_ctx.GetCapability(
                ESYS_TR_NONE,
                ESYS_TR_NONE,
                ESYS_TR_NONE,
                capability,
                prop,
                propertyCount,
            )
