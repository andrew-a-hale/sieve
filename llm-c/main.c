#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/*
 * Wheel-30 segmented Sieve of Eratosthenes.
 *
 * Only numbers coprime to 30 are represented, 8 per block of 30:
 *   1 7 11 13 17 19 23 29
 * Compressed index i = 8*(n/30) + slot[n%30], so i&7 is the wheel slot
 * and the number is 30*(i/8) + WHEEL[i&7].  That is 0.53x the bits of an
 * odd-only sieve, so every clearing pass touches ~half as much memory.
 *
 * A multiple of a prime p >= 7 that survives the wheel is p*m with
 * gcd(m,30) = 1, i.e. 8 arithmetic progressions of constant stride 8*p
 * in index space - one cursor per (prime, slot), no step table, and no
 * division or modulo anywhere in the sweep.
 */

#define WORD_BITS 64
#define SEGMENT_BYTES (256 * 1024)
#define SEGMENT_WORDS (SEGMENT_BYTES / sizeof(uint64_t))
#define SEGMENT_BITS (SEGMENT_WORDS * WORD_BITS)
#define ALL_ONES (~0ULL)

/* residues coprime to 30 */
static const uint8_t WHEEL[8] = {1, 7, 11, 13, 17, 19, 23, 29};
/* slot of n % 30; 9 means "divisible by 2, 3 or 5" */
static const uint8_t SLOT[30] = {0, 0, 9, 9, 9, 9, 9, 1, 9, 9, 9, 2, 9, 3, 9,
                                 9, 9, 4, 9, 5, 9, 9, 9, 6, 9, 9, 9, 9, 9, 7};

/* compressed index of n (n must be coprime to 30) */
static inline uint64_t widx(uint64_t n) { return 8 * (n / 30) + SLOT[n % 30]; }

static uint64_t slots_upto(uint64_t rem) {
  uint64_t c = 0;
  for (uint64_t r = 1; r <= rem; r++) /* residue 0 is not representable */
    c += SLOT[r] != 9;
  return c;
}

/* all odd primes <= top, ascending */
static uint64_t collect_primes(uint64_t top, uint64_t **out) {
  *out = NULL;
  if (top < 3)
    return 0;
  uint64_t fmax = (top + 1) / 2; /* index f <-> number 2f+1 */
  uint64_t words = (fmax + WORD_BITS - 1) / WORD_BITS;
  uint64_t *bits = malloc(words * sizeof(uint64_t));
  for (uint64_t w = 0; w < words; w++)
    bits[w] = ALL_ONES;
  for (uint64_t f = 1; 2 * f * (f + 1) < fmax; f++) {
    if (!(bits[f / WORD_BITS] & (1ULL << (f % WORD_BITS))))
      continue;
    uint64_t p = 2 * f + 1;
    for (uint64_t i = 2 * f * (f + 1); i < fmax; i += p)
      bits[i / WORD_BITS] &= ~(1ULL << (i % WORD_BITS));
  }
  uint64_t n = 0;
  for (uint64_t f = 1; f < fmax; f++)
    n += (bits[f / WORD_BITS] >> (f % WORD_BITS)) & 1;
  uint64_t *pr = malloc((n ? n : 1) * sizeof(uint64_t)), k = 0;
  for (uint64_t f = 1; f < fmax; f++)
    if (bits[f / WORD_BITS] & (1ULL << (f % WORD_BITS)))
      pr[k++] = 2 * f + 1;
  free(bits);
  *out = pr;
  return n;
}

static uint64_t run_sieve(uint64_t limit) {
  if (limit < 2)
    return 0;
  if (limit < 7)
    return limit >= 5 ? 3 : (limit >= 3 ? 2 : 1);

  uint64_t bits_len = 8 * (limit / 30) + slots_upto(limit % 30);

  uint64_t top = (uint64_t)sqrt((double)limit);
  while (top * top > limit)
    top--;
  while ((top + 1) * (top + 1) <= limit)
    top++;

  uint64_t *pr = NULL;
  uint64_t np = collect_primes(top, &pr);
  uint64_t npr = 0;
  for (uint64_t i = 0; i < np; i++)
    if (pr[i] >= 7)
      pr[npr++] = pr[i];

  uint64_t *cursor = calloc(8 * (npr ? npr : 1), sizeof(uint64_t));
  for (uint64_t qi = 0; qi < npr; qi++) {
    uint64_t p = pr[qi];
    for (uint64_t a = 0; a < 8; a++) {
      uint64_t r = WHEEL[a];
      uint64_t m = (r >= p) ? r : r + 30 * ((p - r + 29) / 30);
      cursor[qi * 8 + a] = widx(p * m);
    }
  }

  uint64_t segment[SEGMENT_WORDS];
  uint64_t total = 0;

  for (uint64_t seg = 0; seg < bits_len; seg += SEGMENT_BITS) {
    uint64_t seg_end = seg + SEGMENT_BITS;
    if (seg_end > bits_len)
      seg_end = bits_len;
    uint64_t seg_bits = seg_end - seg;
    uint64_t seg_words = (seg_bits + WORD_BITS - 1) / WORD_BITS;

    for (uint64_t w = 0; w < seg_words; w++)
      segment[w] = ALL_ONES;
    if (seg_bits % WORD_BITS)
      segment[seg_words - 1] = (1ULL << (seg_bits % WORD_BITS)) - 1;

    for (uint64_t qi = 0; qi < npr; qi++) {
      uint64_t stride = 8 * pr[qi];
      uint64_t *cur = &cursor[qi * 8];
      for (uint64_t a = 0; a < 8; a++) {
        if (cur[a] >= seg_end)
          continue;
        uint64_t i = cur[a] - seg;
        for (; i < seg_bits; i += stride)
          segment[i / WORD_BITS] &= ~(1ULL << (i % WORD_BITS));
        cur[a] = seg + i;
      }
    }

    for (uint64_t w = 0; w < seg_words; w++)
      total += __builtin_popcountll(segment[w]);
  }

  free(cursor);
  free(pr);
  return total + 2; /* wheel has no 2, 3 or 5; index 0 is the number 1 */
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

void race(int limit) {
  float timer = 0;
  float delta = 0;
  float ub = 5.0f;

  int count = 0;
  while (timer < ub) {
    clock_t start = clock();
    run_sieve(limit);
    delta = (float)(clock() - start) / CLOCKS_PER_SEC;
    timer += delta;
    count++;
  }

  printf("LLM C         -- Duration: %fs -- Count: %d\n", timer, count);
}

void run(long limit) {
  clock_t start = clock();
  uint64_t count = run_sieve(limit);
  clock_t duration = (clock() - start) / 1000;
  printf("LLM C         -- Duration: %ldms -- Count: %lu\n", duration, count);
}

int main(int argc, char **argv) {
  if (argc < 3)
    return 1;

  long limit = strtoull(strip_separators(argv[1]), NULL, 10);
  long mode = strtol(argv[2], NULL, 10);

  switch (mode) {
  case 0:
    run(limit);
    break;
  case 1:
    race(limit);
    break;
  }

  return 0;
}
