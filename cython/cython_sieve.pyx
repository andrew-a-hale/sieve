from libc.math cimport sqrt


cdef bytearray byte = bytearray(b"\x01")
cdef bytearray zero = bytearray(b"\x00")


cdef class CSieve:
    cdef int _size
    cdef bytearray _bits

    def __cinit__(self, limit):
        self._size = limit
        self._bits = byte * ((self._size + 1) // 2)

    def run_sieve(self):
        cdef char* bits
        cdef int factor, start, step, i, bitslen
        cdef float q

        factor = 1
        q = sqrt(self._size) / 2
        bits = <char*>(self._bits)
        bitslen = len(bits)

        while factor < q:
            for i in range(factor, bitslen):
                if bits[i]:
                    factor = i
                    break

            start = 2 * factor * (factor + 1)
            step = 2 * factor + 1
            while start < bitslen:
                bits[start] = 0
                start += step

            factor += 1

    def count(self):
        return self._bits.count(b"\x01")