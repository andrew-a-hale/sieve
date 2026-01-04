import math

import numpy as np


class Sieve:
    def __init__(self, limit):
        self.bitslength = (limit + 1) // 2
        self.bits = np.ones(self.bitslength, dtype=np.uint8)

    def run(self):
        q = math.sqrt(self.bitslength / 2) + 1
        factor = 1

        while factor < q:
            if self.bits[factor]:
                step = 2 * factor + 1
                start = 2 * factor * (factor + 1)
                self.bits[start::step] = False
            factor += 1

    def check_primes(self):
        return self.bits.sum()
