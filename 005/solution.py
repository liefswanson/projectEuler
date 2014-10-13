from sys import argv
from primeFactoring import primeFactorization
from merge import dumbMergeMax

script, num = argv

num = int(num)

mergedFactors = []

for i in range (2, num+1):
    remainsToFactor = i
    factors = []

    while True:
        factors.append(int (
            primeFactorization( remainsToFactor ) ))
        
        remainsToFactor = int( remainsToFactor/factors[-1] )
        if remainsToFactor == 1:
            break

    mergedFactors = dumbMergeMax(mergedFactors, factors)

solution = 1
for factor in mergedFactors:
    solution *= factor
    #print(factor)

#print("The smallest product of the numbers 1 to " + str(num) + " is " + str(solution))
print(solution)
