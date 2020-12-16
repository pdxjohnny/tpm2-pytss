# TPM2-TSS Python Bindings

These bindings are based on cython, we have rewritten them because SWIG didn't
work out well.

## Status

- pxd files are generated via `tests/test_converter.py`

  - We have all the function defs, typedefs, and struct definitions (with a
    workaround to cython/cython#1305)

## TODO

- We need to get all the `#defines` it shouldn't be too hard to scrape them out
  and put them in the pyx files. We will need to make sure to change the
  typecases to Cython style typecasts

- Need to either write or generate the wrapper functions for each Esys_ and
  Fapi_ call. Most likley just write them.

## Development

You need to install Cython first

> This is due to pip not currently respecting PEP-518 for editable installs
> https://github.com/pypa/pip/pull/6370
> https://discuss.python.org/t/next-steps-for-editable-develop-proof-of-concept/4118/31

```console
$ pip install cython
```

Clone the repo

```console
$ git clone https://github.com/tpm2-software/tpm2-pytss
```

Then you can install this library in development mode

```console
$ pip install -e .
```

## Notes from Bill

This is some manually written cython that calls into ESAPI
and gets a random value.

There is also a callback example that sets a callback handler in Python that is set as a pointer in the C library called libbill, and invokes
it from C code. This should be what FAPI callbacks need.

BUILD:
make
python setup.py build_ext --inplace

RUN:
./test.py -- Tests ESYS and Getrandom.
./test2.py -- Runs the BILL examples.

While this is verbose, you have a ton of control over the API and it's easy to kick out Pythonic things.
GetRandom somehow magically worked as a python array and I have no idea why, but i'll take it.
