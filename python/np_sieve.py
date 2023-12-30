import numpy as np
import math
import time


class Sieve:
    def __init__(self, limit):
        self.limit = limit
        bits = np.ones((limit + 1) // 2, dtype=np.bool_)
        self.bits = bits

    def run_sieve(self):
        for n in range(1, round(math.sqrt(self.limit / 2)) + 1):
            factor = 2 * n + 1
            start = 2 * n * (n+1)
            self.bits[start :: factor] = False

    def check_primes(self):
        return self.bits.sum()


if __name__ == "__main__":
    start = time.perf_counter()
    sieve = Sieve(1000000)
    sieve.run_sieve()

    duration = time.perf_counter() - start
    count = sieve.check_primes()
    print(f"Duration: {duration} -- Count: {count}")
