#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
std::vector<bool> sieve(size_t limit) {
    size_t bitslength = (limit + 1) / 2;
    std::vector<bool> bits(bitslength, true);

    size_t factor = 1;
    double q = sqrt(bitslength / 2) + 1;
    size_t start, step;

    while (factor < q) {
        for (size_t i = factor; i < bitslength; i++) {
            if (bits[i]) {
                factor = i;
                break;
            }
        } 

        start = 2 * factor * (factor + 1);
        step = 2 * factor + 1;
        while (start < bitslength) {
            bits[start] = false;
            start += step;
        }

        factor++;
    }

    return bits;
}

// [[Rcpp::export]]
double check_primes(LogicalVector bits) {
    double count = 0;
    
    for (int i = 0; i < bits.size(); i++) {
        if (bits[i]) {
            count++;
        }
    }

    return count;
}