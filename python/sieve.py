import math


class Sieve:
    def __init__(self, limit):
        self.bitslength = (limit + 1) // 2
        self.bits = [1] * self.bitslength

    def run(self):
        factor = 1
        q = math.sqrt(self.bitslength // 2) + 1

        while factor < q:
            factor = self.bits.index(1, factor)
            start = 2 * factor * (factor + 1)
            size = self.bitslength - start
            step = factor * 2 + 1
            self.bits[start::step] = [0] * ((size // step) + bool(size % step))

            factor += 1

    def check_primes(self):
        return self.bits.count(1)
