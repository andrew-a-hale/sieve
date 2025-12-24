import java.util.BitSet;
import java.util.Collections;

public class Sieve {
	int bitslength;
	BitSet bits;

	public Sieve(int limit) {
		bitslength = (limit + 1) / 2;
		bits = new BitSet(bitslength);
		bits.flip(0, bitslength);
	}

	public void run() {
		int start;
		int step;
    int factor = 1;
		double q = Math.sqrt(this.bitslength / 2);

    while (factor < q) {
			for (int i = factor; i < bitslength; i++) {
				if (this.bits.get(i)) {
					factor = i;
					break;
				}
			}

			start = 2 * factor * (factor + 1);
			step = 2 * factor + 1;
			for (int i = start; i < this.bitslength; i += step) {
				this.bits.clear(i);
			}

      factor += 1;
		}
  }

	public long check() {
		return this.bits.cardinality();
	}

	public static void main(String[] args) {
		int limit = Integer.parseInt(args[0]);
		long start = System.nanoTime();
		Sieve sieve = new Sieve(limit);
		sieve.run();
		long end = System.nanoTime();
		double duration = (end - start) / 1e9;
		System.out.printf("Java          -- Duration: %f -- Count: %d\n", duration, sieve.check());
	}
}
