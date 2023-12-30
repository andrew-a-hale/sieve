import os
import python.fast_sieve as fs
import python.np_sieve as ns
import time
import sys

if len(sys.argv) < 2:
    raise ValueError("missing size argument")
size = int(sys.argv[1])

# CythonSieve
os.system("cd cython && python3 setup.py build_ext --inplace && mv *.so ../python/")
import python.cython_sieve as cs
start = time.perf_counter()
sieve = cs.CSieve(size)
sieve.run_sieve()
duration = time.perf_counter() - start
count = sieve.count()
print(f"Cython -- Duration: {duration} -- Count: {count}")

# FastSieve
start = time.perf_counter()
sieve = fs.FastSieve(size)
sieve.run_sieve()
duration = time.perf_counter() - start
count = sieve.check_primes()
print(f"Python Fast -- Duration: {duration} -- Count: {count}")

# NumpySieve
start = time.perf_counter()
sieve = ns.Sieve(size)
sieve.run_sieve()
duration = time.perf_counter() - start
count = sieve.check_primes()
print(f"Python Numpy -- Duration: {duration} -- Count: {count}")

# GoSieve
os.system(f"go run go/main.go {size}")

# JuliaSieve
os.system(f"julia julia/main.jl {size}")

# RustSieve
os.system(f"rustc -C opt-level=3 -o rust/main rust/src/main.rs && ./rust/main {size}") 