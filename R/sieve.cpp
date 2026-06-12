// [[Rcpp::depends(BH)]]

#include <Rcpp.h>
#include <boost/dynamic_bitset/dynamic_bitset.hpp>

using namespace Rcpp;

// [[Rcpp::export]]
long sieve(size_t limit) {
    size_t bitslength = (limit + 1) / 2;
    boost::dynamic_bitset<> bits(bitslength);

    size_t factor = 1;
    double q = sqrt(bitslength / 2) + 1;
    size_t start, step;

    while (factor < q) {
        for (size_t i = factor; i < bitslength; i++) {
            if (!bits[i]) {
                factor = i;
                break;
            }
        }

        start = 2 * factor * (factor + 1);
        step = 2 * factor + 1;
        while (start < bitslength) {
            bits[start] = true;
            start += step;
        }

        factor++;
    }

    return bits.size() - bits.count();
}
