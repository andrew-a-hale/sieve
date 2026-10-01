package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:time"
import "core:math"
import "base:intrinsics"
import ba "core:container/bit_array"

create_sieve :: proc(sieve: ^ba.Bit_Array, limit: int) {
  if !ba.init(sieve, (limit + 1) / 2) {
    fmt.panicf("unable to create bitset")
  }
}

run_sieve :: proc(sieve: ^ba.Bit_Array) {
  bitslength := ba.len(sieve)
	q := int(math.sqrt(f64(bitslength/2))) + 1
  start, step : int
  factor : int = 1

	for factor < q {
		for i := factor; i < bitslength; i += 1 {
			if !ba.unsafe_get(sieve, i) {
				factor = i
				break
			}
		}

		start = 2 * factor * (factor + 1)
		step = 2 * factor + 1

		for i := start; i < bitslength; i += step {
      #force_inline ba.unsafe_set(sieve, i)
		}

    factor += 1
	}
}

count_sieve :: proc(sieve: ^ba.Bit_Array) -> int {
  n := ba.len(sieve)
  for w in sieve.bits {
    n -= int(intrinsics.count_ones(w))
  }

  return n
}

main :: proc() {
  limit, ok := strconv.parse_int(os.args[1], 10)
  if !ok {
    fmt.panicf("unable to parse limit")
  }

  sw := &time.Stopwatch{}
  time.stopwatch_start(sw)

  sieve : ba.Bit_Array
  create_sieve(&sieve, limit)
  run_sieve(&sieve)
  count := count_sieve(&sieve)
  duration := int(time.duration_milliseconds(time.stopwatch_duration(sw^)))

  fmt.printf("Odin          -- Duration: %dms -- Count: %d", duration, count)
}
