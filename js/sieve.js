class Sieve {
    constructor(limit) {
        this.size = Math.floor((limit + 1) / 2);
        this.bits = Array.from({length: this.size}, _ => true);
    }

    run() {
        var factor = 1;
        var q = Math.sqrt(this.size / 2) + 1;

        while (factor < q) {
            factor = this.bits.findIndex((val, i) => val && i >= factor);
            var start = 2 * factor * (factor + 1);
            var step = 2 * factor + 1;
            for (var i = start; i < this.size; i += step) {
                this.bits[i] = false;
            }
            factor++
        }
    }

    count_primes() {
        var count = 0;
        for (var i = 0; i < this.bits.length; i++) {
            if (this.bits[i]) {
                count++
            }
        }
        return count;
    }
}

var limit = process.argv[2];
var start = performance.now();
var sieve = new Sieve(parseInt(limit));
sieve.run()
console.log(`Javascript    -- Duration: ${(performance.now() - start) / 1000} -- Count: ${sieve.count_primes()}`)
