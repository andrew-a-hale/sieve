import os
import python.fast_sieve as fs
import python.sieve as s
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
sieve.run()
duration = time.perf_counter() - start
count = sieve.check_primes()
print(f"Cython        -- Duration: {duration} -- Count: {count}")

# FastSieve
start = time.perf_counter()
sieve = fs.FastSieve(size)
sieve.run()
duration = time.perf_counter() - start
count = sieve.check_primes()
print(f"Python Fast   -- Duration: {duration} -- Count: {count}")


# Sieve
start = time.perf_counter()
sieve = s.Sieve(size)
sieve.run()
duration = time.perf_counter() - start
count = sieve.check_primes()
print(f"Python Normal -- Duration: {duration} -- Count: {count}")

# NumpySieve
start = time.perf_counter()
sieve = ns.Sieve(size)
sieve.run()
duration = time.perf_counter() - start
count = sieve.check_primes()
print(f"Python Numpy  -- Duration: {duration} -- Count: {count}")

# GoSieve
os.system(f"go run go/main.go {size}")

# JuliaSieve
os.system(f"julia julia/main.jl {size}")

# RustSieve
os.system(f"rustc -C opt-level=3 -o rust/main rust/src/main.rs && ./rust/main {size}")

# RSieve
os.system(f"Rscript R/sieve.R {size}")
os.system(f"Rscript R/rcpp_sieve.R {size}")

# OCamlSieve
os.system(f"cd ocaml && eval $(opam env) && dune build && dune exec ocaml {size}")

# jsSieve
os.system(f"node js/sieve.js {size} NodeJS")
os.system(f'bun js/sieve.js {size} "Bun   "')

# elixirSieve
if size <= 100_000:
    os.system(f"cd elixir/sieve && mix run lib/sieve.ex {size}")
