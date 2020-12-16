import sys
import pathlib
import unittest

from pycparser import c_parser, c_ast, c_generator, parse_file

import pathlib
import textwrap
import tempfile
import subprocess
from typing import List


PROGRAM = r"""
int main() {
    printf("%zu\n", sizeof(SIZEOF_TYPE));
    return 0;
}
"""


def calculate_sizeof(
    sizeof_argument,
    *,
    system_headers: List[str] = None,
    relative_headers: List[str] = None,
    include_dirs: List[pathlib.Path] = None,
):
    pound_include_lines = ["#include <stdio.h>"]
    if system_headers:
        pound_include_lines += [f"#include <{header}>" for header in system_headers]
    if relative_headers:
        pound_include_lines += [f'#include "{header}"' for header in relative_headers]

    with tempfile.TemporaryDirectory(prefix="sizeof_source_") as tempdir:
        sizeof_path = pathlib.Path(tempdir, "sizeof.c")
        sizeof_path.write_text(
            textwrap.dedent("\n".join(pound_include_lines + [PROGRAM]))
        )

        cmd = [
            "gcc",
            "-o",
            str(pathlib.Path(tempdir, "a.out")),
            "-D",
            "SIZEOF_TYPE={}".format(sizeof_argument),
        ]
        # Add include dirs to search for headers
        if include_dirs:
            cmd.append("-I")
            for include_dir in include_dirs:
                cmd.append(str(include_dir))

        # Source file to compile
        cmd.append(str(sizeof_path))
        subprocess.check_call(cmd)

        return int(subprocess.check_output(str(pathlib.Path(tempdir, "a.out"))))


if sys.version_info.major >= 3 and sys.version_info.minor < 9:
    pathlib.Path.is_relative_to = lambda self, other: str(self.resolve()).startswith(
        str(other)
    )

SOURCE_ROOT_DIR = pathlib.Path("/home/pdxjohnny/Documents/c/tpm2-tss").resolve()

C_GENERATOR = c_generator.CGenerator()


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


def Typedef_TypeDecl_Struct_Decl_Type(decl):
    """
    Get the type of a member of a struct
    """
    if hasattr(decl.type.type, "names"):
        return decl.type.type.names[0]
    elif hasattr(decl.type.type, "name"):
        return decl.type.type.name
    elif hasattr(decl.type.type, "declname"):
        return decl.type.type.declname
    raise CouldNotDetermineStructMemberTypeError(decl)


def Typedef_TypeDecl_Struct_Decl_Array_Size(decl) -> int:
    """
    Get the size of a member of a struct that is an array
    """
    if hasattr(decl, "dim"):
        if isinstance(decl.dim, c_ast.Constant):
            return int(decl.dim.value)
        else:
            # TODO Configurable headers locations
            return int(
                calculate_sizeof(
                    C_GENERATOR.visit(decl.dim),
                    system_headers=[
                        pathlib.Path(decl.coord.file).relative_to(
                            SOURCE_ROOT_DIR / "include"
                        )
                    ],
                )
            )
    raise CouldNotDetermineStructMemberArraySizeError(decl)


def Typedef_TypeDecl_Struct(node):
    output = [f"struct {node.name}:"]

    for decl in node.type.type.decls:
        decl_array = ""

        if isinstance(decl.type, c_ast.TypeDecl):
            decl_type = Typedef_TypeDecl_Struct_Decl_Type(decl)
        elif isinstance(decl.type, c_ast.ArrayDecl):
            decl_type = Typedef_TypeDecl_Struct_Decl_Type(decl.type)
            decl_array = f"[{Typedef_TypeDecl_Struct_Decl_Array_Size(decl.type)}]"
        else:
            raise CouldNotDetermineStructMemberTypeError(decl)

        output.append(f"    {decl_type} {decl.name}" + decl_array)
    return "\n".join(output)


def Typedef_TypeDecl(node):
    # typedef combined with declaration of struct
    if isinstance(node.type.type, c_ast.Struct):
        return Typedef_TypeDecl_Struct(node)


class TypedefVisitor(c_ast.NodeVisitor):
    def _visit_Typedef(self, node):
        # typedef combined with declaration
        if isinstance(node.type, c_ast.TypeDecl):
            return Typedef_TypeDecl(node)

    def visit_Typedef(self, node):
        # TODO Restrict this to the file we are parsing, not just the root dir
        if not pathlib.Path(node.coord.file).is_relative_to(SOURCE_ROOT_DIR):
            return

        result = self._visit_Typedef(node)

        if result is not None:
            print(result)

        return
        print("%s at %s" % (node.decl.name, node.decl.coord))


def show_func_defs(filepath: pathlib.Path):
    # Note that cpp is used. Provide a path to your own cpp or
    # make sure one exists in PATH.
    ast = parse_file(
        str(filepath.resolve()),
        use_cpp=True,
        cpp_args="-I" + str(filepath.resolve().parent.parent),
    )

    v = TypedefVisitor()
    v.visit(ast)


class TestConverter(unittest.TestCase):
    def test_struct(self):
        input_file = pathlib.Path("include", "tss2", "tss2_tpm2_types.h")
        input_file = SOURCE_ROOT_DIR / input_file
        show_func_defs(input_file)
