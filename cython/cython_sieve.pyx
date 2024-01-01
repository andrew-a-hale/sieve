from libc.math cimport sqrt


cdef class CSieve:
    cdef int _bitslength
    cdef bytearray _bits

    def __cinit__(self, limit):
        self._bitslength = (limit + 1) // 2
        self._bits = bytearray(b"\x01") * self._bitslength

    def run(self):
        cdef int factor, start, step, i
        cdef float q

        bits = <char*>(self._bits)
        factor = 1
        q = sqrt(self._bitslength // 2) + 1

        while factor < q:
            for i in range(factor, self._bitslength):
                if bits[i]:
                    factor = i
                    break

            start = 2 * factor * (factor + 1)
            step = 2 * factor + 1
            while start < self._bitslength:
                bits[start] = 0
                start += step

            factor += 1

    def check_primes(self):
        return self._bits.count(b"\x01")