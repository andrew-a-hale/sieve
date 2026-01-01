-- primes to 100 UNROLLED
-- with cte as (
--   select 2 as primes
--   union from generate_series(3, 100, 2)
--   except (
--     from generate_series(9, 100, 6) -- 3
--     union from generate_series(25, 100, 10) -- 5
--     union from generate_series(49, 100, 14) -- 7
--   )
-- )
-- select count(*) from cte;

-- primes to N RECURSIVE
-- with recursive marked(p, n) using key(p) as (
--   select 3 as p, generate_series(p*p, N, 2*p)
--   union
--   select p+2 as p, generate_series(p*p, N, 2*p)
--   from marked
--   where p < sqrt(N)
-- )
--
-- select count(*)
-- from (
--   select 2 as primes
--   union from generate_series(3, N, 2)
--   except
--   select unnest(n) from marked
-- );

-- primes to N -- 179 seconds for N=1_000_000_000
with sieve(n) as (
  select 2 as primes
  union from generate_series(3, N, 2)
  except
  select n
  from generate_series(3, sqrt(N)::int, 2) as numbers(p),
  lateral (from generate_series(p*p, N, 2*p)) as marked(n)
)
select count(*)
from sieve;
