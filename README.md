# Sieve

Prime Sieve in multiple languages

## Languages

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
- Java
- Cpp
- C#
- Zig
- DuckDB

## Timings

### Primes Up to 1_000_000_000 / Best

```text
Cython        -- Duration: 2828ms   -- Count: 50847534
Python Fast   -- Duration: 2939ms   -- Count: 50847534
Python Normal -- Duration: 7284ms   -- Count: 50847534
Python Numpy  -- Duration: 9778ms   -- Count: 50847534
Go            -- Duration: 1837ms   -- Count: 50847534
Julia Iter: 0 -- Duration: 1563ms   -- Count: 50847534 // warmup
Julia Iter: 1 -- Duration: 1462ms   -- Count: 50847534
Rust          -- Duration: 1606ms   -- Count: 50847534
R             -- Duration: 8453ms   -- Count: 50847534
Rcpp          -- Duration: 2883ms   -- Count: 50847534
OCaml Fast    -- Duration: 6907ms   -- Count: 50847534
Java          -- Duration: 2027ms   -- Count: 50847534
C++           -- Duration: 1679ms   -- Count: 50847534
C#            -- Duration: 2317ms   -- Count: 50847534
Zig           -- Duration: 1331ms   -- Count: 50847534
Bun           -- Duration: 186787ms -- Count: 50847534
DuckDB        -- Duration: 184786ms -- Count: 50847534
NodeJS        -- Duration: 2484ms   -- Count: 5761455  // ran out of memory for 1_000_000_000
Elixir        -- Duration: 12701ms  -- Count: 78498    // too slow for 1_000_000_000
```

### Primes Up to 1_000_000

```text
Cython        -- Duration: 0ms     -- Count: 78498
Python Fast   -- Duration: 0ms     -- Count: 78498
Python Normal -- Duration: 3ms     -- Count: 78498
Python Numpy  -- Duration: 1ms     -- Count: 78498
Go            -- Duration: 0ms     -- Count: 78498
Julia Iter: 0 -- Duration: 8ms     -- Count: 78498 // warmup
Julia Iter: 1 -- Duration: 0ms     -- Count: 78498
Rust          -- Duration: 0ms     -- Count: 78498
R             -- Duration: 20ms    -- Count: 78498
Rcpp          -- Duration: 2ms     -- Count: 78498
OCaml Fast    -- Duration: 4ms     -- Count: 78498
NodeJS        -- Duration: 16ms    -- Count: 78498
Bun           -- Duration: 7ms     -- Count: 78498
Elixir        -- Duration: 12966ms -- Count: 78498
Java          -- Duration: 5ms     -- Count: 78498
C++           -- Duration: 0ms     -- Count: 78498
C#            -- Duration: 2ms     -- Count: 78498
Zig           -- Duration: 0ms     -- Count: 78498
DuckDB        -- Duration: 54ms    -- Count: 78498
```
