from setuptools import Extension, setup
from Cython.Build import cythonize

ext_modules = [
    Extension("pyesys",
        sources=["pyesys.pyx"],
        libraries=["tss2-esys"]
        )
]

setup(name="pyesys",
    ext_modules = cythonize(ext_modules)
)
