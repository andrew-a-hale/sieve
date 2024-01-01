package main

import (
	"strconv"
	"os"
	"math"
	"time"
	"fmt"
)

type Sieve struct {
	bitslength int
	bits []bool
}

func SieveFactory(limit int) Sieve {
	bitslength := (limit + 1) / 2
	bits := make([]bool, bitslength)
	for i := 0; i < bitslength; i++ {
		bits[i] = true
	}

	return Sieve{bits: bits, bitslength: bitslength}
}

func (s Sieve) run() {
	q := int(math.Sqrt(float64(s.bitslength / 2))) + 1
	var start, step int

	for factor := 1; factor < q; factor++ {
		// find next bits
		for i := factor; i < s.bitslength; i++ {
			if s.bits[i] {
				factor = i
				break
			}
		}

		// mark numbers
		start = 2 * factor * (factor + 1)
		step = 2 * factor + 1
		for ; start < s.bitslength; start+=step {
			s.bits[start] = false
		}
	}
}

func (s Sieve) check_primes() int {
	count := 0	
	for _, b := range s.bits {
		if b {
			count++
		}
	}
	return count
}

func main() {
	limit, _ := strconv.ParseInt(os.Args[1], 10, 0)
	start := time.Now()
	sieve := SieveFactory(int(limit))
	sieve.run()
	fmt.Printf("Go            -- Duration: %f -- Count: %d\n", time.Since(start).Seconds(), sieve.check_primes())
}