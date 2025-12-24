use std::{env, time::SystemTime};

use fixedbitset::FixedBitSet;

pub struct Sieve {
    bitslength: usize,
    bits: FixedBitSet,
}

impl Sieve {
    fn new(limit: usize) -> Sieve {
        let bitslength: usize = limit.div_ceil(2);
        let mut bits: FixedBitSet = FixedBitSet::with_capacity(bitslength);
        bits.toggle_range(..);
        Sieve { bitslength, bits }
    }

    fn run(&mut self) {
        let q: usize = (((self.bitslength / 2) as f32).sqrt()) as usize + 1;
        let mut factor: usize = 1;
        let mut start: usize;
        let mut step: usize;

        while factor < q {
            // find next bit
            for i in factor..self.bitslength {
                if self.bits[i] {
                    factor = i;
                    break;
                }
            }

            // mark numbers
            step = 2 * factor + 1;
            start = 2 * factor * (factor + 1);
            for i in (start..self.bitslength).step_by(step) {
                self.bits.set(i, false);
            }

            factor += 1;
        }
    }

    fn count_primes(self) -> usize {
        self.bits.count_ones(..)
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let limit: usize = args[1].parse::<usize>().unwrap();
    let time = SystemTime::now();
    let mut sieve = Sieve::new(limit);
    sieve.run();
    println!(
        "Rust          -- Duration: {:?} -- Count: {}",
        time.elapsed().unwrap().as_secs_f64(),
        sieve.count_primes()
    )
}
