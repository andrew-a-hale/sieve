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
- Mojo (todo)

# Results
The programs are single-threaded and not optimally written. This should not be taken as a benchmark for the languages.

Below results were done on a 2.6ghz macbook with 16mb RAM.

Calculating primes upto 1,000,000 with duration in seconds.
```
Cython        -- Duration: 0.0010541419906076044 -- Count: 78498
Python Fast   -- Duration: 0.001440813997760415 -- Count: 78498
Python Normal -- Duration: 0.008162404003087431 -- Count: 78498
Python Numpy  -- Duration: 0.002488642989192158 -- Count: 78498
Go            -- Duration: 0.001160 -- Count: 78498
Julia Iter: 0 -- Duration: 0.012526988983154297 -- Count: 78498
Julia Iter: 1 -- Duration: 0.0007979869842529297 -- Count: 78498
Rust          -- Duration: 0.00079 -- Count: 78498
R             -- Duration: 0.0358779430389404 -- Count: 78498
Rcpp          -- Duration: 0.00275206565856934 -- Count: 78498
OCaml Fast    -- Duration: 0.018104 -- Count: 78498
```

Calculating primes upto 10,000,000 with duration in seconds.
```
Cython        -- Duration: 0.012311583006521687 -- Count: 664579
Python Fast   -- Duration: 0.014657235995400697 -- Count: 664579
Python Normal -- Duration: 0.1944303260243032 -- Count: 664579
Python Numpy  -- Duration: 0.04000113799702376 -- Count: 664579
Go            -- Duration: 0.015117 -- Count: 664579
Julia Iter: 0 -- Duration: 0.021266937255859375 -- Count: 664579
Julia Iter: 1 -- Duration: 0.008841991424560547 -- Count: 664579
Rust          -- Duration: 0.009271 -- Count: 664579
R             -- Duration: 0.240325927734375 -- Count: 664579
Rcpp          -- Duration: 0.0274279117584229 -- Count: 664579
OCaml Fast    -- Duration: 0.154751 -- Count: 664579
```

Calculating primes upto 100,000,000 with duration in seconds.
```
Cython        -- Duration: 0.30929452800774015 -- Count: 5761455
Python Fast   -- Duration: 0.3861277360119857 -- Count: 5761455
Python Normal -- Duration: 2.442796892981278 -- Count: 5761455
Python Numpy  -- Duration: 0.9450715290149674 -- Count: 5761455
Go            -- Duration: 0.334042 -- Count: 5761455
Julia Iter: 0 -- Duration: 0.11601495742797852 -- Count: 5761455
Julia Iter: 1 -- Duration: 0.1167299747467041 -- Count: 5761455
Rust          -- Duration: 0.293408 -- Count: 5761455
R             -- Duration: 1.9012930393219 -- Count: 5761455
Rcpp          -- Duration: 0.274863958358765 -- Count: 5761455
OCaml Fast    -- Duration: 1.726690 -- Count: 5761455
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
```

## Julia Iterations
Julia is a JIT compiled language and benefits significantly from a warm-up run when calculating smaller amounts of primes and has less benefit for more primes.

## Julia Issue
Julia at 100,000,000 primes is significantly faster comparatively. Unsure why this is the case.

## OCaml
A more functional OCaml sieve was too slow (x10 slower than the fast version) and was omitted, but the code is still in `ocaml/bin/main.ml`.

# Run
Use `python main.py <n>` to run the sieves. This script will also compile the cython, rust, go, ocaml, and rcpp programs on each run.
