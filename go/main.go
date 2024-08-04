package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
	"time"

	"sieve/bitset"
)

type Sieve struct {
	bitslength uint
	bits       *bitset.BitSet
}

func SieveFactory(limit int) Sieve {
	bitslength := uint((limit + 1) / 2)
	bits := bitset.New(uint(bitslength))

	return Sieve{bits: bits, bitslength: bitslength}
}

func (s Sieve) run() {
	q := uint(math.Sqrt(float64(s.bitslength/2))) + 1
	var factor, start, step uint

	for factor = 1; factor < q; factor++ {
		// find next bits
		for i := factor; i < s.bitslength; i++ {
			if s.bits.Test(i) {
				factor = i
				break
			}
		}

		// mark numbers
		start = 2 * factor * (factor + 1)
		step = 2*factor + 1
		for i := start; i < s.bitslength; i += step {
			s.bits.Clear(i)
		}
	}
}

func (s Sieve) check_primes() uint {
	return s.bits.Count()
}

func main() {
	limit, _ := strconv.ParseInt(os.Args[1], 10, 0)
	start := time.Now()
	sieve := SieveFactory(int(limit))
	sieve.run()
	fmt.Printf("Go            -- Duration: %f -- Count: %d\n", time.Since(start).Seconds(), sieve.check_primes())
}
