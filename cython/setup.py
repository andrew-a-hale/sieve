from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [
    Extension("*", ["*.pyx"]),
]
setup(
    name="My hello app",
    ext_modules=cythonize(extensions),
)
