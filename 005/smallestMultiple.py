from sys import argv
from primeFactoring import primeFactorization

script, num = argv

num = int(num)

def mergeMax (left, right):
    l = 0
    r = 0
    while l < (len(left) or r < len(right)):
        
        
for i in range (2 to num+1):
    remainsToFactor = i
    factors = []

    while True:
        factors.append(int (
            primeFactorization( remainsToFactor ) ))
        
        remainsToFactor = int( remainsToFactor/factors[-1] )
        if remainsToFactor == 1:
            break

            
