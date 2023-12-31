import math


class FastSieve:
    def __init__(self, limit):
        self.size = limit
        self.bitslength = (limit + 1) // 2
        self.bits = bytearray(b"\x01") * self.bitslength

    def run(self):
        factor = 1
        q = math.sqrt(self.size)

        while factor <= q:
            factor = self.bits.index(b"\x01", factor)
            start = 2 * factor * (factor + 1)
            size = self.bitslength - start
            step = factor * 2 + 1
            self.bits[start::step] = b"\x00" * ((size // step) + bool(size % step))

            factor += 1

    def check_primes(self):
        return self.bits.count(b"\x01")
