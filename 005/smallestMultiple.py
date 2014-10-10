from sys import argv
import primeFactoring

script, num = argv

num = int(num)

factors = []

while True:
    factors.append(int (primeFactoring.primeFactorization(num)))
    print(factors[-1])
    num = int(num/factors[-1])
    if num == 1:
        break
