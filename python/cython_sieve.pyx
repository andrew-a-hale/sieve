from libc.math cimport sqrt


cdef class CSieve:
    cdef int _bitslength
    cdef bytearray _bits

    def __cinit__(self, limit):
        self._bitslength = (limit + 1) // 2
        self._bits = bytearray(b"\xff") * ((self._bitslength + 7) // 8)

    def run(self):
        cdef int factor, start, step, i
        cdef float q

        bits = <char*>(self._bits)
        factor = 1
        q = sqrt(self._bitslength // 2) + 1

        while factor < q:
            for i in range(factor, self._bitslength):
                if bits[i >> 3] & (1 << (i & 7)):
                    factor = i
                    break

            start = 2 * factor * (factor + 1)
            step = 2 * factor + 1
            while start < self._bitslength:
                bits[start >> 3] &= ~(1 << (start & 7))
                start += step

            factor += 1

    def check_primes(self):
        cdef int count = 0
        cdef int i
        for i in range(self._bitslength):
            if self._bits[i >> 3] & (1 << (i & 7)):
                count += 1

        return count
