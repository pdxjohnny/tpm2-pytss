import sys
import pathlib
import unittest

from pprint import pprint

from pycparser import c_parser, c_ast, c_generator, parse_file

import pathlib
import textwrap
import tempfile
import itertools
import subprocess
from typing import List, Tuple


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
                    C_GENERATOR.visit(decl.dim), system_headers=config.system_headers,
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


def convert_files(config: ConvertConfig, filepaths: List[Tuple[pathlib.Path, str]]):
    file_c_defines = {}
    file_c_imports = {}
    file_c_dependencies = {}

    for filepath, _outfile in filepaths:
        file_c_defines[filepath] = convert_pxd_file(config, filepath)

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
        pass

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
