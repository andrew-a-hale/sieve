import os
import sys
import time

import python.cython_sieve as cs
import python.fast_sieve as fs
import python.np_sieve as ns
import python.sieve as s

if len(sys.argv) < 2:
    raise ValueError("missing size argument")
size = int(sys.argv[1])

# CythonSieve
os.system(
    "cd cython && python3 setup.py build_ext --inplace > /dev/null && mv *.so ../python/"
)

start = time.perf_counter()
sieve = cs.CSieve(size)
sieve.run()
duration = int((time.perf_counter() - start) * 1000)
count = sieve.check_primes()
print(f"Cython        -- Duration: {duration}ms -- Count: {count}")

# FastSieve
start = time.perf_counter()
sieve = fs.FastSieve(size)
sieve.run()
duration = int((time.perf_counter() - start) * 1000)
count = sieve.check_primes()
print(f"Python Fast   -- Duration: {duration}ms -- Count: {count}")

# Sieve
start = time.perf_counter()
sieve = s.Sieve(size)
sieve.run()
duration = int((time.perf_counter() - start) * 1000)
count = sieve.check_primes()
print(f"Python Normal -- Duration: {duration}ms -- Count: {count}")

# NumpySieve
start = time.perf_counter()
sieve = ns.Sieve(size)
sieve.run()
duration = int((time.perf_counter() - start) * 1000)
count = sieve.check_primes()
print(f"Python Numpy  -- Duration: {duration}ms -- Count: {count}")

# GoSieve
os.system(f"cd go && go run main.go {size}")

# JuliaSieve
os.system(f"julia julia/main.jl {size}")

# RustSieve
os.system(f"cd rust && cargo run -q --release {size}")

# RSieve
os.system(f"Rscript R/sieve.R {size}")
os.system(f"Rscript R/rcpp_sieve.R {size}")

# OCamlSieve
os.system(f"cd ocaml && eval $(opam env) && dune build && dune exec ocaml {size}")

# NodeJsSieve
if size <= 100_000_000:
    os.system(f"node js/sieve.js {size} NodeJS")
else:
    print("NodeJS        -- Duration: Skipped -- Too Slow")


# BunSieve
if size <= 100_000_000:
    os.system(f'bun js/sieve.js {size} "Bun   "')
else:
    print("Bun           -- Duration: Skipped -- Too Slow")


# elixirSieve
if size <= 1_000_000:
    os.system(f"cd elixir && elixir sieve.exs {size}")
else:
    print("Elixir        -- Duration: Skipped -- Too Slow")


# JavaSieve
os.system(f"cd java && javac Sieve.java && java Sieve {size}")

# CppSieve
os.system(f"cd cpp && make > /dev/null && ./main {size}")

# CsSieve
os.system(f"cd csharp && make > /dev/null && ./main/csharp - {size}")

# ZigSieve
os.system(f"cd zig && zig run -O ReleaseFast main.zig -- {size}")

# DuckDBSieve
if size <= 100_000_000:
    os.system(f"cd duckdb && ./go.sh {size}")
else:
    print("DuckDB        -- Duration: Skipped -- Too Slow\n")
