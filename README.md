# Sieve

Prime Sieve in multiple languages

## Languages

- Python
- Python + NumPy
- Cython
- Julia
- Go
- Rust
- R / Rcpp
- Rcpp
- OCaml
- JS (NodeJS + Bun)
- Elixir
- Java
- C
- C#
- Zig
- DuckDB

## Timings

### Primes Up to 1_000_000_000 / Best

```text
Cython        -- Duration: 1501ms   -- Count: 50847534
Python Fast   -- Duration: 2913ms   -- Count: 50847534
Python Normal -- Duration: 6245ms   -- Count: 50847534
Python Numpy  -- Duration: 2907ms   -- Count: 50847534
Go            -- Duration: 1821ms   -- Count: 50847534
Julia Iter: 0 -- Duration: 1457ms   -- Count: 50847534 // warmup
Julia Iter: 1 -- Duration: 1412ms   -- Count: 50847534
Rust          -- Duration: 1498ms   -- Count: 50847534
R             -- Duration: 7984ms   -- Count: 50847534
Rcpp          -- Duration: 1394ms   -- Count: 50847534
OCaml Fast    -- Duration: 6664ms   -- Count: 50847534
Java          -- Duration: 1906ms   -- Count: 50847534
C             -- Duration: 1485ms   -- Count: 50847534
C#            -- Duration: 2198ms   -- Count: 50847534
Zig           -- Duration: 1288ms   -- Count: 50847534
DuckDB        -- Duration: 176730ms -- Count: 50847534
Bun           -- Duration: 175869ms -- Count: 50847534
NodeJS        -- Duration: 2500ms   -- Count: 5761455  // ran out of memory for 1_000_000_000
Elixir        -- Duration: 127ms    -- Count: 9592    // too slow for 1_000_000_000
```

### Primes Up to 1_000_000

```text
Cython        -- Duration: 0ms  -- Count: 78498
Python Fast   -- Duration: 0ms  -- Count: 78498
Python Normal -- Duration: 3ms  -- Count: 78498
Python Numpy  -- Duration: 0ms  -- Count: 78498
Go            -- Duration: 0ms  -- Count: 78498
Julia Iter: 0 -- Duration: 8ms  -- Count: 78498
Julia Iter: 1 -- Duration: 0ms  -- Count: 78498
Rust          -- Duration: 0ms  -- Count: 78498
R             -- Duration: 20ms -- Count: 78498
Rcpp          -- Duration: 0ms  -- Count: 78498
OCaml Fast    -- Duration: 4ms  -- Count: 78498
NodeJS        -- Duration: 17ms -- Count: 78498
Bun           -- Duration: 7ms  -- Count: 78498
Java          -- Duration: 5ms  -- Count: 78498
C             -- Duration: 0ms  -- Count: 78498
C#            -- Duration: 3ms  -- Count: 78498
DuckDB        -- Duration: 55ms -- Count: 78498
Zig           -- Duration: 1ms  -- Count: 78498
Elixir        -- Duration: Skipped -- Too Slow
```
