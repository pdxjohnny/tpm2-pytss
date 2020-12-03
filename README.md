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
