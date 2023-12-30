import time

sprimes = []
lprimes = []


def sieve(n: int) -> list:
    rootn = n**0.5
    for num in range(3, n + 1, 2):
        prime = True
        for p in sprimes:
            if num % p == 0:
                prime = False
                break

        if prime and num < rootn:
            sprimes.append(num)
        elif prime:
            lprimes.append(num)

    return sprimes + lprimes


start = time.perf_counter()
sieve(100000)
print(f"Global Defined     - Duration: {time.perf_counter() - start}")
