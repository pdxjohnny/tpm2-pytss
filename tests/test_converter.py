import sys
import pathlib
import unittest

from pycparser import c_parser, c_ast, c_generator, parse_file

import pathlib
import textwrap
import tempfile
import subprocess
from typing import List


def compiler_flags_for_include_dirs(include_dirs):
    cmd = []
    for include_dir in include_dirs:
        cmd += ["-I", include_dir]
    return cmd


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
    include_dirs: List[str] = None,
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
            cmd += compiler_flags_for_include_dirs(include_dirs)

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


class UnknownTypeDeclError(Exception):
    def __init__(self, node):
        super().__init__(f"Don't know what to do with {node.coord}: {node}")


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


def Typedef_TypeDecl_Struct_Decl_Type(config, decl):
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


def Typedef_TypeDecl_Struct_Decl_Array_Size(config, decl) -> int:
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
                    C_GENERATOR.visit(decl.dim), system_headers=config.system_headers,
                )
            )
    raise CouldNotDetermineStructMemberArraySizeError(decl)


def Typedef_TypeDecl_Struct_Union(config, struct_or_union: str, node):
    output = [f"{struct_or_union} {node.name}:"]

    decl_types = set()
    for decl in node.type.type.decls:
        decl_array = ""

        if isinstance(decl.type, c_ast.TypeDecl):
            decl_type = Typedef_TypeDecl_Struct_Decl_Type(config, decl)
        elif isinstance(decl.type, c_ast.ArrayDecl):
            decl_type = Typedef_TypeDecl_Struct_Decl_Type(config, decl.type)
            decl_array = (
                f"[{Typedef_TypeDecl_Struct_Decl_Array_Size(config, decl.type)}]"
            )
        else:
            raise CouldNotDetermineStructMemberTypeError(decl)

        decl_types.add(decl_type)
        output.append(f"    {decl_type} {decl.name}" + decl_array)
    return "\n".join(output), decl_types


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


class TypedefVisitor(c_ast.NodeVisitor):
    def _visit_Typedef(self, config, node):
        # typedef combined with declaration
        if isinstance(node.type, c_ast.TypeDecl):
            return Typedef_TypeDecl(config, node)


from typing import NamedTuple


class ConvertConfig(NamedTuple):
    system_headers: List[str]
    relative_headers: List[str]
    include_dirs: List[str]


def convert_file(config: ConvertConfig, filepath: pathlib.Path):
    # Note that cpp is used. Provide a path to your own cpp or
    # make sure one exists in PATH.
    ast = parse_file(str(filepath.resolve()), use_cpp=True)

    file_defines = {}
    file_dependencies = set()

    class FileTypedefVisitor(TypedefVisitor):
        def visit_Typedef(self, node):
            nonlocal file_defines
            nonlocal file_dependencies

            if not pathlib.Path(node.coord.file).is_relative_to(filepath):
                return

            converted, dependencies = self._visit_Typedef(config, node)

            if converted is None:
                return

            file_defines[node.name] = converted
            file_dependencies.update(dependencies)

    v = FileTypedefVisitor()
    v.visit(ast)

    file_dependencies.difference_update(set(file_defines.keys()))

    return file_defines, file_dependencies


class TestConverter(unittest.TestCase):
    def test_struct(self):
        include_dir = SOURCE_ROOT_DIR / "include"
        config = ConvertConfig(
            system_headers=[], relative_headers=[], include_dirs=[str(include_dir)]
        )

        input_file = include_dir / "tss2" / "tss2_tpm2_types.h"
        convert_file(
            config._replace(system_headers=["tss2/tss2_tpm2_types.h"]), input_file
        )

        return

        input_file = include_dir / "tss2" / "tss2_common.h"
        convert_file(input_file)
