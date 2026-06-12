// Package bitset
// Implementation of a dynamic sized bitset
package bitset

import (
	"fmt"
	"strings"
)

type BitSet struct {
	Length uint
	Data   []uint
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

	return &BitSet{Length: length, Data: set}
}

func (bs *BitSet) Len() uint {
	return bs.Length
}

func (bs *BitSet) Get(i uint) uint {
	return uint(bs.Data[i/wordSize] >> (i % wordSize) & 1)
}

func (bs *BitSet) Test(i uint) bool {
	return bs.Get(i) == 1
}

func (bs *BitSet) Set(i uint) {
	bs.Data[i/wordSize] |= (1 << (i % wordSize))
}

func (bs *BitSet) Clear(i uint) {
	bs.Data[i/wordSize] &= (allBits ^ 1<<(i%wordSize))
}

func (bs *BitSet) Flip() {
	leftover := bs.Length % wordSize
	for i := range bs.Data {
		if i == len(bs.Data)-1 {
			bs.Data[i] ^= (1 << leftover) - 1
		} else {
			bs.Data[i] ^= allBits
		}
	}
}

func (bs *BitSet) MostSignificantBit() uint {
	var i int
	var j uint
	for i = 0; i < len(bs.Data); i++ {
		tmp := bs.Data[i]
		for j = 0; tmp > 0; j++ {
			tmp >>= 1
		}
	}

	return uint(i-1)*wordSize + j - 1
}

func (bs *BitSet) Count() uint {
	var count uint = 0
	for _, bs := range bs.Data {
		tmp := bs
		for tmp > 0 {
			count += (tmp & 1)
			tmp >>= 1
		}
	}

	return count
}

func (bs *BitSet) String() string {
	var s strings.Builder
	for _, bitset := range bs.Data {
		tmp := bitset
		for range wordSize {
			fmt.Fprint(&s, tmp&1)
			if len(s.String()) == int(bs.Len()) {
				break
			}
			tmp >>= 1
		}
	}

	var r []byte
	for i := len(s.String()) - 1; i >= 0; i-- {
		r = append(r, s.String()[i])
	}

	return string(r)
}
