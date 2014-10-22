from sys import argv
import primes

script, n = argv

n = int(n)

primesList = primes.genPrimesUntil(n)

tally = 0
for prime in primesList:
    tally += prime.value

print(tally)
