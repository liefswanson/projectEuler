from sys import argv
from primeFactoring import primeFactorization

script, num = argv

num = int(num)

factors = []

while True:
    factors.append(int (primeFactorization(num)))
    print(factors[-1])
    num = int(num/factors[-1])
    if num == 1:
        break
