# Sieve
Prime Sieve in multiple languages

# Languages
- Python
- Python + NumPy
- Cython
- Julia
- Go
- Rust

# Results
Calculating primes upto 1,000,000 with duration in seconds.
```
Cython        -- Duration: 0.0010325490147806704
Python Fast   -- Duration: 0.0014414070174098015
Python Numpy  -- Duration: 0.0020004019897896796
Go            -- Duration: 0.001431
Julia Iter: 0 -- Duration: 0.012896060943603516
Julia Iter: 1 -- Duration: 0.0009369850158691406
Rust          -- Duration: 0.000963
```

Calculating primes upto 10,000,000 with duration in seconds.
```
Cython        -- Duration: 0.011565071006771177
Python Fast   -- Duration: 0.01653865701518953
Python Numpy  -- Duration: 0.033117940998636186
Go            -- Duration: 0.012858
Julia Iter: 0 -- Duration: 0.020022153854370117
Julia Iter: 1 -- Duration: 0.008819818496704102
Rust          -- Duration: 0.010357
```

Calculating primes upto 100,000,000 with duration in seconds.
```
Cython        -- Duration: 0.3524915549787693
Python Fast   -- Duration: 0.4262897960143164
Python Numpy  -- Duration: 0.9671202870085835
Go            -- Duration: 0.387338
Julia Iter: 0 -- Duration: 0.11850905418395996
Julia Iter: 1 -- Duration: 0.11523699760437012
Rust          -- Duration: 0.337009
```

Calculating primes upto 1,000,000,000 with duration in seconds.
```
Cython        -- Duration: 4.6992673040076625
Python Fast   -- Duration: 5.259457616019063
Python Numpy  -- Duration: 14.83121354400646
Go            -- Duration: 4.517262
Julia Iter: 0 -- Duration: 4.192141056060791
Julia Iter: 1 -- Duration: 4.230482816696167
Rust          -- Duration: 5.265943
```

## Julia Iterations
Julia is a JIT compiled language and benefits significantly from a warm-up run.
