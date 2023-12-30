use std::{env, time::SystemTime};

pub struct Sieve {
    bitslength: usize,
    bits: Vec<bool>,
    debug: bool,
}

impl Sieve {
    fn new(limit: usize, debug: bool) -> Sieve {
        Sieve {
            bitslength: (limit + 1) / 2,
            bits: vec![true; (limit + 1) / 2],
            debug: debug,
        }
    }

    fn run(&mut self) {
        let q: usize = (self.bitslength as f32).sqrt() as usize;
        let mut factor: usize = 1;
        let mut start: usize;
        let mut step: usize;

        while factor <= q {
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
                self.bits[i] = false;
            }

            factor += 1;
        }
    }

    fn count_primes(self) -> usize {
        let mut sum: usize = 0;
        for (i, b) in self.bits.iter().enumerate() {
            if *b {
                sum += 1;
                if self.debug {
                    print!("{},", 2 * i + 1);
                }
            }
        }

        sum
    }
}

fn main() {
    let debug: bool = false;
    let args: Vec<String> = env::args().collect();
    let limit: usize = args[1].parse::<usize>().unwrap();
    let time = SystemTime::now();
    let mut sieve = Sieve::new(limit, debug);
    sieve.run();
    println!("Rust -- Duration: {:?} -- Count: {}", time.elapsed().unwrap().as_secs_f64(), sieve.count_primes())
}
