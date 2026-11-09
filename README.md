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
- OCaml
- JS (NodeJS + Bun)
- Elixir
- Java
- C
- C#
- Zig
- DuckDB
- Odin
- lua

## Timings

### Primes Up to 1_000_000_000 / Best

```text
Cython        -- Duration: 1445ms -- Count: 50847534
Python Fast   -- Duration: 2830ms -- Count: 50847534
Python Normal -- Duration: 6142ms -- Count: 50847534
Python Numpy  -- Duration: 2841ms -- Count: 50847534
Go            -- Duration: 1712ms -- Count: 50847534
Julia Iter: 0 -- Duration: 1315ms -- Count: 50847534 // warmup
Julia Iter: 1 -- Duration: 1310ms -- Count: 50847534
Rust          -- Duration: 1460ms -- Count: 50847534
R             -- Duration: 7859ms -- Count: 67624750
Rcpp          -- Duration: 1357ms -- Count: 50847534
OCaml Fast    -- Duration: 6643ms -- Count: 50847534
Java          -- Duration: 1885ms -- Count: 50847534
C             -- Duration: 1413ms -- Count: 50847534
C#            -- Duration: 2157ms -- Count: 50847534
DuckDB        -- Duration: 143040ms -- Count: 50847534
Zig           -- Duration: 1229ms -- Count: 50847534
LLM C         -- Duration: 155ms -- Count: 50847534
Odin          -- Duration: 1222ms -- Count: 50847534
Lua           -- Duration: 12561ms -- Count: 50847534
NodeJS        -- Duration: Skipped -- Run out of Memory
Bun           -- Duration: Skipped -- Run out of Memory
LuaJIT        -- Duration: Skipped -- Table Overflow
NodeJS        -- Duration: 2500ms   -- Count: 5761455  // ran out of memory for 1_000_000_000
Elixir        -- Duration: 127ms    -- Count: 9592     // too slow for 1_000_000_000
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
Odin          -- Duration: 1ms  -- Count: 78498
Lua           -- Duration: 10ms -- Count: 78498
LuaJIT        -- Duration: 3ms --  Count: 78498
Elixir        -- Duration: Skipped -- Too Slow
```
