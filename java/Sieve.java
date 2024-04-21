import java.util.ArrayList;
import java.util.Collections;

public class Sieve {
	int bitslength;
	ArrayList<Boolean> bits;

	public Sieve(int limit) {
		bitslength = (limit + 1) / 2;
		bits = new ArrayList<Boolean>(Collections.nCopies(bitslength, true));
	}

	public void run() {
		int start;
		int step;
		double q = Math.sqrt(this.bitslength / 2);

		for (int factor = 1; factor < q; factor++) {
			factor += this.bits.subList(factor, this.bitslength).indexOf(true);
			if (factor < 0) {
				break;
			}

			start = 2 * factor * (factor + 1);
			step = 2 * factor + 1;
			while (start < this.bitslength) {
				this.bits.set(start, false);
				start += step;
			}
		}
	}

	public long check() {
		return this.bits.stream().filter(x -> x).count();
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
