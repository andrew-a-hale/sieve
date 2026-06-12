#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/*
 * Segmented odd-only Sieve of Eratosthenes.
 *
 * Index i in the bitset represents the odd number 2*i+1.
 * For a prime p = 2*f+1, multiples are cleared starting from
 * p^2 at index (p^2-1)/2 = 2*f*(f+1), stepping by p.
 *
 * The full range is processed in 32 KB segments that fit in
 * L1 data cache.  Segments are allocated once on the stack and
 * reused.  Word-at-a-time clearing (precomputed 64-bit masks)
 * is used for primes <= 64; per-bit clearing for larger primes.
 */

#define WORD_BITS 64
#define SEGMENT_BYTES (32 * 1024)
#define SEGMENT_WORDS (SEGMENT_BYTES / sizeof(uint64_t))
#define SEGMENT_INDICES (SEGMENT_WORDS * WORD_BITS)
#define ALL_ONES (~0ULL)

/* Max odd primes <= 64: 3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61 = 17 */
#define MAX_SMALL_PRIMES 18

typedef struct {
  uint64_t masks[WORD_BITS]; /* precomputed word mask for each bit offset */
  uint64_t word_adv[WORD_BITS];
  uint64_t next_p0[WORD_BITS];
} SmallPrime;

/*
 * Index formulas for the odd-only representation.
 * factor f in [0, bw) corresponds to prime p = 2*f+1.
 * For p = 2*f+1, the first index to clear is
 *   (p^2 - 1) / 2  =  2*f*(f+1).
 */
static inline uint64_t prime_of(uint64_t factor) { return 2 * factor + 1; }
static inline uint64_t start_of(uint64_t factor) {
  return 2 * factor * (factor + 1);
}
static inline uint64_t pstart_of(uint64_t p) { return (p * p - 1) / 2; }

static uint64_t run_sieve(uint64_t limit) {
  if (limit < 2)
    return 0;
  if (limit == 2)
    return 1;

  uint64_t bits_len = (limit + 1) / 2;

  /* ---- small sieve: find all primes up to sqrt(limit) ---- */
  uint64_t max_factor = (uint64_t)sqrt(bits_len / 2.0) + 1;
  uint64_t max_words = (max_factor + WORD_BITS - 1) / WORD_BITS;

  uint64_t *small = calloc(max_words, sizeof(uint64_t));
  for (uint64_t w = 0; w < max_words; w++)
    small[w] = ALL_ONES;

  for (uint64_t f = 1; f < max_factor; f++) {
    if (!(small[f / WORD_BITS] & (1ULL << (f % WORD_BITS))))
      continue;
    uint64_t p = prime_of(f), s = start_of(f);
    for (uint64_t i = s; i < max_factor; i += p)
      small[i / WORD_BITS] &= ~(1ULL << (i % WORD_BITS));
  }

  /* Collect odd primes (p >= 3) */
  uint64_t *primes = malloc(max_factor * sizeof(uint64_t));
  uint64_t num_primes = 0;
  for (uint64_t f = 1; f < max_factor; f++)
    if (small[f / WORD_BITS] & (1ULL << (f % WORD_BITS)))
      primes[num_primes++] = prime_of(f);
  free(small);

  uint64_t *prime_val = malloc(num_primes * sizeof(uint64_t));
  uint64_t *prime_start = malloc(num_primes * sizeof(uint64_t));
  for (uint64_t i = 0; i < num_primes; i++) {
    prime_val[i] = primes[i];
    prime_start[i] = pstart_of(primes[i]);
  }
  free(primes);

  /* ---- precompute word masks for primes <= 64 ---- */
  SmallPrime small_tables[MAX_SMALL_PRIMES];
  uint64_t num_small = 0;
  for (uint64_t i = 0; i < num_primes && prime_val[i] <= WORD_BITS; i++) {
    uint64_t p = prime_val[i];
    for (uint64_t p0 = 0; p0 < WORD_BITS; p0++) {
      uint64_t mask = 0, count = 0;
      for (uint64_t b = p0; b < WORD_BITS; b += p) {
        mask |= 1ULL << b;
        count++;
      }
      uint64_t next_idx = p0 + count * p;
      small_tables[num_small].masks[p0] = mask;
      small_tables[num_small].word_adv[p0] = next_idx / WORD_BITS;
      small_tables[num_small].next_p0[p0] = next_idx % WORD_BITS;
    }
    num_small++;
  }

  /* ---- segmented sweep ---- */
  uint64_t segment[SEGMENT_WORDS];
  uint64_t total = 0;

  for (uint64_t seg = 0; seg < bits_len; seg += SEGMENT_INDICES) {
    uint64_t seg_end = seg + SEGMENT_INDICES;
    if (seg_end > bits_len)
      seg_end = bits_len;
    uint64_t seg_indices = seg_end - seg;
    uint64_t seg_words = (seg_indices + WORD_BITS - 1) / WORD_BITS;

    /* Initialise segment: all bits = candidate prime */
    for (uint64_t w = 0; w < seg_words; w++)
      segment[w] = ALL_ONES;
    if (seg_indices % WORD_BITS)
      segment[seg_words - 1] = (1ULL << (seg_indices % WORD_BITS)) - 1;

    /* Small primes: word-at-a-time with precomputed tables */
    for (uint64_t pi = 0; pi < num_small; pi++) {
      uint64_t p = prime_val[pi];
      uint64_t st = prime_start[pi];
      if (st >= seg_end)
        continue;

      uint64_t first = (st >= seg) ? st : st + ((seg - st + p - 1) / p) * p;
      if (first >= seg_end)
        continue;

      uint64_t w = (first - seg) / WORD_BITS;
      uint64_t p0 = (first - seg) % WORD_BITS;
      SmallPrime *t = &small_tables[pi];

      while (w < seg_words) {
        segment[w] &= ~t->masks[p0];
        w += t->word_adv[p0];
        p0 = t->next_p0[p0];
      }
    }

    /* Large primes: per-bit clearing (one hit per word at most) */
    for (uint64_t pi = num_small; pi < num_primes; pi++) {
      uint64_t p = prime_val[pi];
      uint64_t st = prime_start[pi];
      if (st >= seg_end)
        continue;

      uint64_t first = (st >= seg) ? st : st + ((seg - st + p - 1) / p) * p;
      if (first >= seg_end)
        continue;

      for (uint64_t i = first - seg; i < seg_indices; i += p)
        segment[i / WORD_BITS] &= ~(1ULL << (i % WORD_BITS));
    }

    /* Popcount the segment */
    for (uint64_t w = 0; w < seg_words; w++)
      total += __builtin_popcountll(segment[w]);
  }

  free(prime_val);
  free(prime_start);
  return total;
}

static char *strip_separators(char *s) {
  char *p = s;
  while (*p) {
    if (*p == '_')
      memmove(p, p + 1, strlen(p));
    else
      p++;
  }
  return s;
}

int main(int argc, char **argv) {
  if (argc < 2)
    return 1;

  uint64_t limit = strtoull(strip_separators(argv[1]), NULL, 10);

  struct timespec t0, t1;
  clock_gettime(CLOCK_MONOTONIC, &t0);
  uint64_t count = run_sieve(limit);
  clock_gettime(CLOCK_MONOTONIC, &t1);

  int64_t ms =
      (t1.tv_sec - t0.tv_sec) * 1000 + (t1.tv_nsec - t0.tv_nsec) / 1000000;
  printf("C             -- Duration: %ldms -- Count: %lu\n", ms, count);
  return 0;
}
