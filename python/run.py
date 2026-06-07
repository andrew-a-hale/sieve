import subprocess

# CythonSieve
subprocess.run(["python3", "setup.py", "build_ext", "--inplace"])

import sys  # noqa: E402
import time  # noqa: E402
import cython_sieve as cs  # noqa: E402
import fast_sieve as fs  # noqa: E402
import np_sieve as ns  # noqa: E402
import sieve as s  # noqa: E402

if len(sys.argv) < 2:
    raise ValueError("failed expected size parameter, got nothing")

size = int(sys.argv[1])

# Cython
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
