import pathlib
import unittest

from pycparser import c_parser, c_ast, parse_file


class TypedefVisitor(c_ast.NodeVisitor):
    def visit_Typedef(self, node):
        print(node.__dir__())
        print(node)
        return
        print('%s at %s' % (node.decl.name, node.decl.coord))


def show_func_defs(filepath: pathlib.Path):
    # Note that cpp is used. Provide a path to your own cpp or
    # make sure one exists in PATH.
    ast = parse_file(str(filepath.resolve()), use_cpp=True,
                     cpp_args='-I' + str(filepath.resolve().parent.parent))

    ast_str = str(ast)

    print(ast_str[:4000])

    v = TypedefVisitor()
    v.visit(ast)


class TestConverter(unittest.TestCase):
    def test_struct(self):
        input_file = pathlib.Path("tpm2-tss", "include", "tss2",
                "tss2_tpm2_types.h")
        input_file = pathlib.Path("/home/pdxjohnny/Documents/c") / input_file
        show_func_defs(input_file)
