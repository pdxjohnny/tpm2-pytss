import sys
import pathlib
import unittest

from pprint import pprint

from pycparser import c_parser, c_ast, c_generator, parse_file

import re
import pathlib
import textwrap
import tempfile
import itertools
import contextlib
import subprocess
import dataclasses
import concurrent.futures
from typing import List, Tuple, Union, Type


def compiler_flags_for_include_dirs(include_dirs):
    cmd = []
    for include_dir in include_dirs:
        cmd += ["-I", include_dir]
    return cmd


PROGRAM = r"""
int main() {
    printf("REPLACE_FSTRING\n", REPLACE_ARGUMENT);
    return 0;
}
"""


def calculate_sizeof(
    sizeof_argument,
    fstring: str,
    argument: str,
    macro: str,
    *,
    system_headers: List[str] = None,
    relative_headers: List[str] = None,
    include_dirs: List[str] = None,
    quiet: bool = False,
):
    pound_include_lines = ["#include <stdio.h>"]
    if system_headers:
        pound_include_lines += [f"#include <{header}>" for header in system_headers]
    if relative_headers:
        pound_include_lines += [f'#include "{header}"' for header in relative_headers]

    with tempfile.TemporaryDirectory(prefix="sizeof_source_") as tempdir:
        sizeof_path = pathlib.Path(tempdir, "sizeof.c")
        sizeof_path.write_text(
            textwrap.dedent(
                "\n".join(
                    pound_include_lines
                    + [
                        PROGRAM.replace("REPLACE_FSTRING", fstring).replace(
                            "REPLACE_ARGUMENT", argument
                        )
                    ]
                )
            )
        )

        cmd = [
            "gcc",
            "-o",
            str(pathlib.Path(tempdir, "a.out")),
            "-D",
            "{}={}".format(macro, sizeof_argument),
        ]
        # Add include dirs to search for headers
        if include_dirs:
            cmd += compiler_flags_for_include_dirs(include_dirs)

        # Source file to compile
        cmd.append(str(sizeof_path))
        if quiet:
            subprocess.check_output(cmd, stderr=subprocess.STDOUT)
        else:
            subprocess.check_call(cmd)

        return subprocess.check_output(str(pathlib.Path(tempdir, "a.out")))


if sys.version_info.major >= 3 and sys.version_info.minor < 9:
    pathlib.Path.is_relative_to = lambda self, other: str(self.resolve()).startswith(
        str(other)
    )

SOURCE_ROOT_DIR = pathlib.Path("/home/pdxjohnny/Documents/c/tpm2-tss").resolve()

C_GENERATOR = c_generator.CGenerator()


class UnknownTypeDeclError(Exception):
    def __init__(self, node):
        super().__init__(f"Don't know what to do with {node.coord}: {node}")


class UnknownTypeNameError(Exception):
    def __init__(self, node):
        super().__init__(f"Don't know how to find type name of {node.coord}: {node}")


class CouldNotDetermineStructMemberTypeError(Exception):
    def __init__(self, decl):
        super().__init__(
            f"Could not determine struct member type of {decl.coord}: {decl}"
        )


class CouldNotDetermineStructMemberArraySizeError(Exception):
    def __init__(self, decl):
        super().__init__(
            f"Could not determine struct member array size of {decl.coord}: {decl}"
        )


def type_name(config, node):
    if isinstance(
        node,
        (
            c_ast.Typename,
            c_ast.FuncDecl,
            c_ast.Typedef,
            c_ast.Decl,
            c_ast.PtrDecl,
            c_ast.TypeDecl,
            c_ast.ArrayDecl,
        ),
    ):
        return type_name(config, node.type)
    elif isinstance(node, c_ast.IdentifierType):
        if hasattr(node, "names"):
            return node.names[0]
        elif hasattr(node, "name"):
            return node.name
        elif hasattr(node, "declname"):
            return node.declname
    else:
        raise UnknownTypeNameError(node)


def Typedef_TypeDecl_Struct_Decl_Array_Size(config, decl) -> int:
    """
    Get the size of a member of a struct that is an array
    """
    if hasattr(decl, "dim"):
        if isinstance(decl.dim, c_ast.Constant):
            return int(decl.dim.value)
        else:
            return int(
                calculate_sizeof(
                    C_GENERATOR.visit(decl.dim),
                    "%zu",
                    "sizeof(SIZEOF_TYPE)",
                    "SIZEOF_TYPE",
                    system_headers=config.system_headers,
                )
            )
    raise CouldNotDetermineStructMemberArraySizeError(decl)


def Typedef_TypeDecl_Struct_Union_With_Members(config, struct_or_union: str, node):
    output = [f"{struct_or_union} {node.name}:"]

    decl_types = set()
    for decl in node.type.type.decls:
        decl_array = ""

        if isinstance(decl.type, (c_ast.TypeDecl, c_ast.PtrDecl)):
            decl_type = type_name(config, decl)
        elif isinstance(decl.type, c_ast.ArrayDecl):
            decl_type = type_name(config, decl.type)
            decl_array = (
                f"[{Typedef_TypeDecl_Struct_Decl_Array_Size(config, decl.type)}]"
            )
        else:
            raise CouldNotDetermineStructMemberTypeError(decl)

        decl_types.add(decl_type)
        output.append(f"    {decl_type} {decl.name}" + decl_array)
    return "\n".join(output), decl_types


def Typedef_TypeDecl_Struct_Union(config, struct_or_union: str, node):
    if node.type.type.decls is None:
        if node.type.type.name == node.name:
            # Opaque struct
            return f"struct {node.name}:\n    pass", set()
        else:
            # For: typedef struct name_a name_b
            return (
                f"ctypedef {node.type.type.name} {node.type.type.name}",
                {node.type.type.name},
            )
    else:
        # For all other cases, structs and unions with members
        return Typedef_TypeDecl_Struct_Union_With_Members(config, struct_or_union, node)


def Typedef_TypeDecl(config, node):
    # typedef combined with declaration of struct
    if isinstance(node.type.type, (c_ast.Struct, c_ast.Union)):
        return Typedef_TypeDecl_Struct_Union(
            config, node.type.type.__class__.__qualname__.lower(), node
        )
    elif isinstance(node.type.type, c_ast.IdentifierType):
        return (
            f"ctypedef {node.type.type.names[0]} {node.name}",
            {node.type.type.names[0]},
        )
    else:
        raise UnknownTypeDeclError(node)


def Typedef_PtrDecl_FuncDecl(config, node):
    dependencies = set()
    dependencies.add(type_name(config, node))
    for param in node.type.type.args.params:
        dependencies.add(type_name(config, param))
    return C_GENERATOR.visit(node), dependencies


def Typedef_FuncDecl(config, node):
    dependencies = set()
    dependencies.add(type_name(config, node))
    for param in node.args.params:
        dependencies.add(type_name(config, param))
    return C_GENERATOR.visit(node), dependencies


class TypedefVisitor(c_ast.NodeVisitor):
    def _visit_Typedef(self, config, node):
        # typedef combined with declaration
        if isinstance(node.type, c_ast.TypeDecl):
            return Typedef_TypeDecl(config, node)
        elif isinstance(node.type, c_ast.PtrDecl) and isinstance(
            node.type.type, c_ast.FuncDecl
        ):
            return Typedef_PtrDecl_FuncDecl(config, node)
        raise NotImplementedError(f"Don't know what to do with {node.coord} {node}")


from typing import Dict, NamedTuple


class ConvertConfig(NamedTuple):
    system_headers: List[str]
    relative_headers: List[str]
    include_dirs: List[str]
    overrides: Dict[str, str]


def convert_pxd_file(config: ConvertConfig, filepath: pathlib.Path):
    # Marshalling library requires use of fake_libc_include since it includes
    # stdlib.h
    ast = parse_file(
        str(filepath.resolve()),
        use_cpp=True,
        cpp_args=[
            "-nostdinc",
            "-D__attribute__(x)=",
            "-D__extension__(x)=",
            "-I" + str(pathlib.Path("..", "pycparser", "utils", "fake_libc_include")),
        ],
    )

    file_defines = {}
    file_dependencies = set()

    class FileTypedefVisitor(TypedefVisitor):
        def visit_Typedef(self, node):
            nonlocal file_defines
            nonlocal file_dependencies

            if not pathlib.Path(node.coord.file).is_relative_to(filepath):
                return

            try:
                converted, dependencies = self._visit_Typedef(config, node)
            except:
                print(node)
                print(C_GENERATOR.visit(node))
                raise

            if converted is None:
                return

            file_defines[node.name] = (
                converted,
                dependencies,
            )
            file_dependencies.update(dependencies)

        def visit_FuncDecl(self, node):
            nonlocal file_defines
            nonlocal file_dependencies

            if not pathlib.Path(node.coord.file).is_relative_to(filepath):
                return

            try:
                converted, dependencies = Typedef_FuncDecl(config, node)
            except:
                print(node)
                print(C_GENERATOR.visit(node))
                raise

            if converted is None:
                return

            name = node.type.declname
            file_defines[name] = (
                converted,
                dependencies,
            )
            file_dependencies.update(dependencies)

    v = FileTypedefVisitor()
    v.visit(ast)

    file_dependencies.difference_update(set(file_defines.keys()))

    return file_defines


class Const:
    def __repr__(self):
        return self.__class__.__name__[1:]


class _CYTHON_DEFINE_NO_VALUE(Const):
    pass


class _CYTHON_DEFINE_NO_TYPEDEF(Const):
    pass


CYTHON_DEFINE_NO_VALUE = _CYTHON_DEFINE_NO_VALUE()
CYTHON_DEFINE_NO_TYPEDEF = _CYTHON_DEFINE_NO_TYPEDEF()

# This matches (TYPE_NAME) C style type casts that are found within #defines
# \( and \) mean that we are searching for the following when it is prefixed by
# a '(' and followed by a ')'
# []+ says include all the characters within [] until a character not within []
#   a-z says lowercase 'a' through 'z' should be included in search
#   A-Z says uppercase 'a' through 'z' should be included in search
#   0-9 says '0' through '9' should be included in search
#   _ says underscore should be included in search
CYTHON_DEFINE_FIND_TYPEDEF_REGEX = re.compile(r"\([a-zA-Z0-9_]+\)")


@dataclasses.dataclass
class CPoundDefine:
    """
    Used for parsing #define. Holds the definition name and it's contents (body)
    """

    name: str
    body: str


@dataclasses.dataclass
class CythonDefine:
    """
    Cython translation of a :py:class:`CPoundDefine` object. The Python variable
    assignment equivalent with Cython typecast if applicable.
    """

    name: str
    typedef: Union[str, Type[_CYTHON_DEFINE_NO_TYPEDEF]]
    value: Union[str, Type[_CYTHON_DEFINE_NO_VALUE]]
    c_pound_define: CPoundDefine

    def __str__(self):
        if self.value is CYTHON_DEFINE_NO_VALUE:
            return repr(self)
        # If the define has a typedef then format it in Cython's syntax
        typedef = self.typedef
        if typedef is CYTHON_DEFINE_NO_TYPEDEF:
            typedef = ""
        else:
            typedef = "<" + typedef + ">"
        # Write out the Python variable assignment version of the define
        return self.name + " = " + typedef + self.value

    @staticmethod
    def find_value(
        config: ConvertConfig, define: CPoundDefine
    ) -> Union[int, Type[_CYTHON_DEFINE_NO_VALUE]]:
        """
        Try to find the size
        """
        # Do not try to calculate value for function macros
        if "(" in define.name:
            return CYTHON_DEFINE_NO_VALUE
        # If we have a negative constant don't try to convert to hex
        if define.body.startswith("-"):
            return define.body
        # Shorthand struct defines (not .member = syntax, just comma separated)
        if define.body.startswith("{") and define.body.endswith("}"):
            return "(" + define.body[1:-1] + ")"
        # Convert the value to hex
        return hex(
            int(
                calculate_sizeof(
                    define.body,
                    "%llx",
                    "POUND_DEFINE",
                    "POUND_DEFINE",
                    system_headers=config.system_headers,
                    quiet=True,
                ),
                16,
            )
        )

    @staticmethod
    def find_typedef(
        _config: ConvertConfig, define: CPoundDefine
    ) -> Union[str, Type[_CYTHON_DEFINE_NO_TYPEDEF]]:
        # Regex to look for typedef
        for match in CYTHON_DEFINE_FIND_TYPEDEF_REGEX.findall(define.body):
            # Remove parenthesizes
            match = match[1:-1]
            # Check if this is a valid type name. Does it start with a letter
            if match[:1].isalpha():
                return match
        return CYTHON_DEFINE_NO_TYPEDEF

    @classmethod
    def from_c_pound_define(cls, config: ConvertConfig, define: CPoundDefine):
        return cls(
            name=define.name,
            typedef=cls.find_typedef(config, define),
            value=cls.find_value(config, define),
            c_pound_define=define,
        )


def convert_pyx_file(config: ConvertConfig, filepath: pathlib.Path):
    POUND_DEFINE = "#define"
    defines = {}
    current_define = CPoundDefine(name="", body="")
    for line in filepath.read_text().split("\n"):
        line = line.strip()
        # Check if we have a new definition
        if line.startswith(POUND_DEFINE):
            # If we found a new define set the name
            current_define.name = line.split()[1]
            # Set the line to be the part not including #define or the name
            line = line.split(maxsplit=2)[-1]
            # Do not include header guards or definitions without values
            if line == current_define.name:
                current_define.name = ""
        # If we are currently parsing as define
        if current_define.name:
            # Keep adding until end of definition
            if line.endswith("\\"):
                # Add line but remove backslash
                current_define.body += line[:-1]
                continue
            # Add line
            current_define.body += line
            # Add to dictionary of defines
            defines[current_define.name] = current_define
            # Create a new blank current definition
            current_define = CPoundDefine(name="", body="")
    # Remove header guards
    # We can use a with statement to ensure threads are cleaned up promptly
    with concurrent.futures.ThreadPoolExecutor() as executor:
        # Start the load operations and mark each future with its URL
        future_to_name = {
            executor.submit(CythonDefine.from_c_pound_define, config, define): name
            for name, define in defines.items()
        }
        for future in concurrent.futures.as_completed(future_to_name):
            exception = future.exception()
            if exception is not None:
                raise exception
            defines[future_to_name[future]] = future.result()
    return defines


def convert_files(config: ConvertConfig, filepaths: List[Tuple[pathlib.Path, str]]):
    file_py_defines = {}
    file_c_defines = {}
    file_c_imports = {}
    file_c_dependencies = {}

    for filepath, _outfile in filepaths:
        file_c_defines[filepath] = convert_pxd_file(config, filepath)
        file_py_defines[filepath] = convert_pyx_file(config, filepath)

    for type_name, definition_dependencies in config.overrides.items():
        for filepath, definitions in file_c_defines.items():
            if type_name in definitions:
                if definition_dependencies is not None:
                    definitions[type_name] = definition_dependencies
                else:
                    del definitions[type_name]
                break

    for filepath, definitions in file_c_defines.items():
        # Make the dependencies the union of all the dependencies
        file_c_dependencies[filepath] = set(
            itertools.chain(
                *[dependencies for _definition, dependencies in definitions.values()]
            )
        )
        # Remove types which are defined in the file from the files dependencies
        file_c_dependencies[filepath].difference_update(set(definitions.keys()))

    for filepath, dependencies in file_c_dependencies.items():
        for type_name in dependencies:
            for defined_in_filepath, definitions in file_c_defines.items():
                if type_name in definitions:
                    file_c_imports.setdefault(filepath, {})
                    file_c_imports[filepath].setdefault(defined_in_filepath, set())
                    file_c_imports[filepath][defined_in_filepath].add(type_name)
                    break

    for filepath in file_c_imports.keys():
        print(
            filepath,
            file_c_dependencies[filepath].difference(
                set(itertools.chain(*file_c_imports[filepath].values()))
            ),
        )

    outfiles = dict(filepaths)

    for filepath, outfile in filepaths:
        # Write out pxd file
        with open(outfile.with_suffix(".pxd"), "w") as fileobj:
            fileobj.write(
                textwrap.dedent(
                    """
                from libc.stdint cimport (
                    int8_t,
                    uint8_t,
                    int16_t,
                    uint16_t,
                    int32_t,
                    uint32_t,
                    int64_t,
                    uint64_t,
                )
            \n"""
                ).lstrip()
            )
            for upstream_filepath, type_names in dict(
                sorted(file_c_imports.get(filepath, {}).items())
            ).items():
                upstream_outfile = outfiles[upstream_filepath]
                fileobj.write(f"from {upstream_outfile.stem} cimport (\n")
                for type_name in sorted(type_names):
                    fileobj.write(f"    {type_name},\n")
                fileobj.write(")\n")
                fileobj.write("\n")
            fileobj.write("\n")
            fileobj.write(
                'cdef extern from "<'
                + str(filepath.relative_to(SOURCE_ROOT_DIR / "include"))
                + '>":\n'
            )
            for definition, _dependencies in file_c_defines[filepath].values():
                fileobj.write(textwrap.indent(definition, "    ") + "\n\n")
        # Write out pyx file
        with open(outfile.with_suffix(".pyx"), "w") as fileobj:
            for define in file_py_defines.get(filepath, {}).values():
                # Skip if the define has no value
                if define.value is CYTHON_DEFINE_NO_VALUE:
                    print("No value for", define, file=sys.stderr)
                    continue
                # Write out the Cython variable assignment version of the define
                fileobj.write(str(define) + "\n")

    # pprint(file_c_imports)
    # pprint(file_c_defines)
    # pprint(file_c_dependencies)


class TestConverter(unittest.TestCase):
    def test_struct(self):
        # Uncomment to re-run conversion
        include_dir = SOURCE_ROOT_DIR / "include"

        filepaths = [
            (
                include_dir / "tss2" / filename,
                pathlib.Path(__file__).parent.parent
                / "tpm2_pytss"
                / filename.replace(".h", "_h"),
            )
            for filename in [
                "tss2_common.h",
                "tss2_tpm2_types.h",
                "tss2_mu.h",
                "tss2_tcti.h",
                "tss2_sys.h",
                "tss2_esys.h",
                "tss2_fapi.h",
            ]
        ]

        config = ConvertConfig(
            system_headers=[
                filepath.relative_to(include_dir) for filepath, _ in filepaths
            ],
            relative_headers=[],
            include_dirs=[str(include_dir)],
            overrides={
                "TSS2_TCTI_CONTEXT": ("struct TSS2_TCTI_CONTEXT:\n    pass", set()),
                "TSS2_SYS_CONTEXT": ("struct TSS2_SYS_CONTEXT:\n    pass", set()),
                "pollfd": None,
            },
        )

        convert_files(config, filepaths)
