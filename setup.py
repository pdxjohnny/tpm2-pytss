import ast
import pathlib

from Cython.Build import cythonize
from setuptools import Extension, find_packages, setup

NAME = "tpm2-pytss"
IMPORT_NAME = NAME.replace("-", "_")

SELF_PATH = pathlib.Path(__file__).parent

README = (SELF_PATH / "README.md").read_text()

for line in (SELF_PATH / IMPORT_NAME / "version.py").read_text().split("\n"):
    if line.startswith("VERSION"):
        VERSION = ast.literal_eval(line.strip().split("=")[-1].strip())
        break

setup(
    name=NAME,
    version=VERSION,
    description="TPM 2.0 TSS Bindings for Python",
    long_description=README,
    long_description_content_type="text/markdown",
    author="John Andersen",
    author_email="john.s.andersen@intel.com",
    maintainer="John Andersen",
    maintainer_email="john.s.andersen@intel.com",
    url="https://github.com/tpm2-software/tpm2-pytss",
    license="BSD",
    keywords=["tpm2", "security"],
    classifiers=[
        "Development Status :: 1 - Planning",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: BSD License",
        "Natural Language :: English",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3 :: Only",
        "Programming Language :: Python :: 3.5",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: Implementation :: CPython",
    ],
    install_requires=[],
    extras_require={
        "dev": [
            "coverage",
            "codecov",
            "sphinx",
            "sphinxcontrib-asyncio",
            "black==19.10b0",
            "sphinx_rtd_theme",
            "cryptography>=2.8",
        ],
    },
    packages=find_packages(exclude=["*.tests", "*.tests.*", "tests.*", "tests"]),
    include_package_data=True,
    ext_modules=cythonize(
        [
            Extension("pyesys", sources=["pyesys.pyx"], libraries=["tss2-esys"]),
            Extension("bill", sources=["bill.pyx", "libbill.c"]),
        ],
        compiler_directives={"language_level": "3"},
    ),
)
