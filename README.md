# Sieve
Prime Sieve in multiple languages

# Languages
- Python
- Python + NumPy
- Cython
- Julia
- Go
- Rust
- R
- Rcpp
- OCaml
- JS (NodeJS + Bun)
- Elixir
- Mojo (todo)
- Java

# Results
The programs are single-threaded and not optimally written. This should not be taken as a benchmark for the languages.

Calculating primes upto 1,000,000 with duration in seconds.
```
Cython        -- Duration: 0.00034767703618854284 -- Count: 78498
Python Fast   -- Duration: 0.0006087810033932328 -- Count: 78498
Python Normal -- Duration: 0.002821333007887006 -- Count: 78498
Python Numpy  -- Duration: 0.0011631520465016365 -- Count: 78498
Go            -- Duration: 0.000731 -- Count: 78498
Julia Iter: 0 -- Duration: 0.0029349327087402344 -- Count: 78498
Julia Iter: 1 -- Duration: 0.00037980079650878906 -- Count: 78498
Rust          -- Duration: 0.000444999 -- Count: 78498
R             -- Duration: 0.0179712772369385 -- Count: 78498
Rcpp          -- Duration: 0.000938177108764648 -- Count: 78498
OCaml Fast    -- Duration: 0.004515 -- Count: 78498
NodeJS        -- Duration: 0.01837072694301605 -- Count: 78498
Bun           -- Duration: 0.005889131000000001 -- Count: 78498
Java          -- Duration: 0.004634 -- Count: 78498
```

Calculating primes upto 10,000,000 with duration in seconds.
```
Cython        -- Duration: 0.003894323017448187 -- Count: 664579
Python Fast   -- Duration: 0.006021483975928277 -- Count: 664579
Python Normal -- Duration: 0.06533905398100615 -- Count: 664579
Python Numpy  -- Duration: 0.012452005001250654 -- Count: 664579
Go            -- Duration: 0.006686 -- Count: 664579
Julia Iter: 0 -- Duration: 0.007447957992553711 -- Count: 664579
Julia Iter: 1 -- Duration: 0.00478816032409668 -- Count: 664579
Rust          -- Duration: 0.004827041 -- Count: 664579
R             -- Duration: 0.0795862674713135 -- Count: 664579
Rcpp          -- Duration: 0.00805234909057617 -- Count: 664579
OCaml Fast    -- Duration: 0.048284 -- Count: 664579
NodeJS        -- Duration: 0.16200657498836518 -- Count: 664579
Bun           -- Duration: 0.042294568 -- Count: 664579
Java          -- Duration: 0.012866 -- Count: 664579
```

Calculating primes upto 100,000,000 with duration in seconds.
```
Cython        -- Duration: 0.16573790996335447 -- Count: 5761455
Python Fast   -- Duration: 0.17573900002753362 -- Count: 5761455
Python Normal -- Duration: 0.7769032049691305 -- Count: 5761455
Python Numpy  -- Duration: 0.4871221029898152 -- Count: 5761455
Go            -- Duration: 0.074234 -- Count: 5761455
Julia Iter: 0 -- Duration: 0.05281710624694824 -- Count: 5761455
Julia Iter: 1 -- Duration: 0.049902915954589844 -- Count: 5761455
Rust          -- Duration: 0.053659681 -- Count: 5761455
R             -- Duration: 1.00384616851807 -- Count: 5761455
Rcpp          -- Duration: 0.124225378036499 -- Count: 5761455
OCaml Fast    -- Duration: 0.762027 -- Count: 5761455
NodeJS        -- Duration: 2.711799802005291 -- Count: 5761455
Bun           -- Duration: 0.672857661 -- Count: 5761455
Java          -- Duration: 0.084811 -- Count: 5761455
```

Calculating primes upto 1,000,000,000 with duration in seconds.
```
Cython        -- Duration: 4.560784330999013 -- Count: 50847534
Python Fast   -- Duration: 4.730918754998129 -- Count: 50847534
Python Normal -- Duration: 37.52011579897953 -- Count: 50847534
Python Numpy  -- Duration: 15.579333100002259 -- Count: 50847534
Go            -- Duration: 4.171424 -- Count: 50847534
Julia Iter: 0 -- Duration: 3.87786602973938 -- Count: 50847534
Julia Iter: 1 -- Duration: 3.729544162750244 -- Count: 50847534
Rust          -- Duration: 3.9630520000000002 -- Count: 50847534
R             -- Duration: 21.1558890342712 -- Count: 50847534
Rcpp          -- Duration: 4.4062659740448 -- Count: 50847534
OCaml Fast    -- Duration: 16.437602 -- Count: 50847534
NodeJS        -- Ran out of memory.
Bun           -- Took too long.
Java          -- Duration: 2.184566 -- Count: 50847534
```

## Julia Iterations
Julia is a JIT compiled language and benefits significantly from a warm-up run when calculating smaller amounts of primes and has less benefit for more primes.

## Julia Issue
Julia at 100,000,000 primes is significantly faster comparatively. Unsure why this is the case.

## OCaml
A more functional OCaml sieve was too slow (x10,000 slower than the fast version for primes up to 1,000,000 and worse for larger n) and was omitted, but the code is still in `ocaml/bin/main.ml`.

## Elixir
Omitted from all benchmarks 

# Run
Use `python main.py <n>` to run the sieves. This script will also compile the cython, rust, go, ocaml, and rcpp programs on each run.

## Dependencies
The python script assumes that normal tooling and some packages have been installed for each of the languages.
