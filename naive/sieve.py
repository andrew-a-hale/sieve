import time

sprimes = [2]
lprimes = []


def sieve(n: int, sprimes: list, lprimes: list) -> list:
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
sieve(100000, sprimes, lprimes)
print(f"Function Argument  - Duration: {time.perf_counter() - start}")
