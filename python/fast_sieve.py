import math
import time


class FastSieve:
    def __init__(self, limit):
        self.limit = limit
        self.bits = bytearray(b"\x01") * ((self.limit + 1) // 2)

    def run_sieve(self):
        factor = 1
        bitslen = len(self.bits)
        q = math.sqrt(self.limit)

        while factor <= q:
            factor = self.bits.index(b"\x01", factor)
            start = 2 * factor * (factor + 1)
            size = bitslen - start
            step = factor * 2 + 1
            self.bits[start::step] = b"\x00" * ((size // step) + bool(size % step))

            factor += 1

    def check_primes(self):
        return self.bits.count(b"\x01")

if __name__ == "__main__":
    start = time.perf_counter()
    sieve = FastSieve(1000000)
    sieve.run_sieve()

    duration = time.perf_counter() - start
    count = sieve.check_primes()
    print(f"Duration: {duration} -- Count: {count}")
