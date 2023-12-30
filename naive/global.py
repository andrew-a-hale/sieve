import time

start = time.perf_counter()
sprimes = []
lprimes = []
n = 100000

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


print(f"No Function        - Duration: {time.perf_counter() - start}")
