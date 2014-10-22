from sys import argv
from math import trunc, floor

def sumToN(n):
    return trunc((n*(n+1))/2)

def sumMultiplesToN(i, n):
    return i*sumToN(floor(n/i))

_, cap, m, n = argv

cap = int(cap)-1 #non inclusive on the right hand bound

m = int(m)
n = int(n)

print(sumMultiplesToN(m, cap) +
      sumMultiplesToN(n, cap) -
      sumMultiplesToN(m*n, cap))
