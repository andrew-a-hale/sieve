#include <boost/dynamic_bitset.hpp>
#include <chrono>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <cstdio>
#include <ctime>

class Sieve {
  boost::dynamic_bitset<> bits;
  size_t size;

public:
  Sieve(size_t limit) {
    size = (limit + 1) / 2;
    bits.resize(size);
  }
  int64_t check() { return this->size - this->bits.count(); };
  void run();
};

void Sieve::run() {
  size_t start;
  size_t step;
  size_t factor = 1;
  size_t q = std::sqrt(this->size / 2) + 1;

  while (factor < q) {
    for (size_t i = factor; i < this->size; i++) {
      if (!this->bits[i]) {
        factor = i;
        break;
      };
    };

    step = 2 * factor + 1;
    start = 2 * factor * (factor + 1);
    for (size_t i = start; i < this->size; i += step) {
      this->bits.set(i);
    }

    factor += 1;
  };
}

int main(int argc, char *argv[]) {
  if (argc == 1) {
    return 1;
  }

  int limit = std::atoi(argv[1]);
  std::chrono::time_point<std::chrono::system_clock> start =
      std::chrono::system_clock::now();

  Sieve sieve = Sieve(limit);
  sieve.run();
  auto count = sieve.check();

  std::chrono::time_point<std::chrono::system_clock> end =
      std::chrono::system_clock::now();
  auto duration =
      std::chrono::duration_cast<std::chrono::milliseconds>(end - start)
          .count();

  printf("C++           -- Duration: %ldms -- Count: %ld\n", duration, count);
  return 0;
}
