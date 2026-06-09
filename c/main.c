#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

static inline char GetBit(unsigned char *bits, long i) {
  return bits[i >> 3] >> (i & 7) & 1;
}

static inline void SetBit(unsigned char *bits, long i) {
  bits[i >> 3] |= 1 << (i & 7);
}

char *StringRemoveChar(char *s, char d) {
  int i, j;
  int len = strlen(s);
  for (int i = j = 0; i < len; i++) {
    if (s[i] != d) {
      s[j++] = s[i];
    }
  }
  s[j] = '\0';
  return s;
}

int main(int argc, char **argv) {
  if (argc == 1) {
    return 1;
  }

  char *input = StringRemoveChar(*(++argv), '_');
  long limit = strtol(input, NULL, 10);
  long size = (limit + 1) / 2;

  unsigned char *bits = calloc((size + 7) / 8, 1);

  clock_t start = clock();
  long curr;
  long step;
  long factor = 1;
  long q = 1 + sqrt(size / 2.0);

  while (factor < q) {
    for (long i = factor; i < size; i++) {
      if (!GetBit(bits, i)) {
        factor = i;
        break;
      }
    }

    step = 2 * factor + 1;
    curr = 2 * factor * (factor + 1);
    for (long i = curr; i < size; i += step) {
      SetBit(bits, i);
    }

    factor += 1;
  }

  long count = 0;
  for (long i = 0; i < size; i++) {
    if (!GetBit(bits, i)) {
      count++;
    }
  }

  clock_t duration = clock() - start;

  printf("C             -- Duration: %ldms -- Count: %ld\n",
         duration * 1000 / CLOCKS_PER_SEC, count);

  return 0;
}
