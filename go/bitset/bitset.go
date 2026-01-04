// Package bitset
// Implementation of a dynamic sized bitset
package bitset

import "fmt"

type BitSet struct {
	length uint
	data   []uint
}

const (
	wordSize = uint(1 << 6)
	allBits  = 0xffffffffffffffff
)

func New(length uint) *BitSet {
	var set []uint
	reqWords := length / wordSize
	leftover := length % wordSize

	for i := 0; i < int(reqWords); i++ {
		set = append(set, 1<<wordSize-1)
	}

	if leftover > 0 {
		set = append(set, (1<<leftover)-1)
	}

	return &BitSet{length: length, data: set}
}

func (bs *BitSet) Len() uint {
	return bs.length
}

func (bs *BitSet) Get(i uint) uint {
	return uint(bs.data[i/wordSize] >> (i % wordSize) & 1)
}

func (bs *BitSet) Test(i uint) bool {
	return bs.Get(i) == 1
}

func (bs *BitSet) Set(i uint) {
	bs.data[i/wordSize] |= (1 << (i % wordSize))
}

func (bs *BitSet) Clear(i uint) {
	bs.data[i/wordSize] &= (allBits ^ 1<<(i%wordSize))
}

func (bs *BitSet) Flip() {
	for i := range bs.data {
		bs.data[i] ^= (1 << (bs.length)) - 1
	}
}

func (bs *BitSet) MostSignificantBit() uint {
	var i uint
	var j uint
	for _, bs := range bs.data {
		tmp := bs
		for j = 0; tmp > 0; j++ {
			tmp >>= 1
		}
	}

	return i*wordSize + j - 1
}

func (bs *BitSet) Count() uint {
	var count uint = 0
	for _, bs := range bs.data {
		tmp := bs
		for tmp > 0 {
			count += (tmp & 1)
			tmp >>= 1
		}
	}

	return count
}

func (bs *BitSet) String() string {
	s := ""
	for _, bitset := range bs.data {
		tmp := bitset
		for range wordSize {
			s += fmt.Sprint(tmp & 1)
			if len(s) == int(bs.Len()) {
				break
			}
			tmp >>= 1
		}
	}

	var r []byte
	for i := len(s) - 1; i >= 0; i-- {
		r = append(r, s[i])
	}

	return string(r)
}
