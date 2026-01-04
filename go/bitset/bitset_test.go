package bitset

import "testing"

func TestGet(t *testing.T) {
	bs := New(10)
	val := bs.Get(9)

	if val != 1 {
		t.Errorf("Expected '1' got %v\n", val)
	}
}

func TestTest(t *testing.T) {
	bs := New(10)
	bs.Clear(1)

	if val := bs.Test(1); val {
		t.Errorf("Expected 'false' got %v\n", val)
	}
}

func TestClear(t *testing.T) {
	bs := New(10)
	bs.Clear(0)

	val := bs.Get(0)
	if val != 0 {
		t.Errorf("Expected '0' got %v\n", val)
	}
}

func TestSet(t *testing.T) {
	bs := New(10)
	bs.Clear(0)
	bs.Set(0)

	val := bs.Get(0)
	if val != 1 {
		t.Errorf("Expected '1' got %v\n", val)
	}
}

func TestFlip(t *testing.T) {
	bs := New(4)

	bs.Flip()
	if val := bs.Get(1); val != 0 {
		t.Errorf("Expected '0' got %v\n", val)
	}

	bs.Flip()
	if val := bs.Get(1); val != 1 {
		t.Errorf("Expected '1' got %v\n", val)
	}

	if val := bs.Len(); val != 4 {
		t.Errorf("Expected '4' got %v\n", val)
	}
}

func TestMostSignificantBit(t *testing.T) {
	bs := New(4)

	if val := bs.MostSignificantBit(); val != 3 {
		t.Errorf("Expected '3' got %v\n", val)
	}

	bs.Clear(3)
	if val := bs.MostSignificantBit(); val != 2 {
		t.Errorf("Expected '2' got %v\n", val)
	}
}

func TestCount(t *testing.T) {
	bs := New(10)
	if x := bs.Count(); x != 10 {
		t.Errorf("Expected '10' got %v\n", x)
	}

	bs.Clear(1)
	bs.Clear(3)
	bs.Clear(5)
	bs.Clear(7)
	bs.Clear(9)

	if x := bs.Count(); x != 5 {
		t.Errorf("Expected '5' got %v\n", x)
	}
}
