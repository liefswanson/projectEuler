import math

#object used to contain a prime number
class Prime(object):
    
    #constructor
    def __init__(self, value):
        self.value = value
        self.distanceToNextMultiple = value
        
    #tostring
    def __str__(self):
        return str(self.value)
        
    #used to generate the next piece of the prime's generating function
    def generate(self, iterations=1):
        self.distanceToNextMultiple -= iterations

        if self.distanceToNextMultiple <= 0:
            self.distanceToNextMultiple += self.value
            
    #check the value at the current part of the prime's generating function
    def checkPrimality(self):
        if self.distanceToNextMultiple == self.value:
            return False
        else:
            return True


def primeFactorization(num):
    activePrimes = []
    inactivePrimes = []

    activePrimes.append(Prime(2))
    inactivePrimes.append(Prime(3))

    if (num % 2) == 0:
        return 2
        
    if (num % 3) == 0:
        return 3

    activePrimes[0].generate()
    
    for n in range (4, int(math.ceil(math.sqrt(num+1)))):
        isPrime = True

        for prime in activePrimes:
           prime.generate()
           isPrime = isPrime and prime.checkPrimality()

        if inactivePrimes[0].value**2 == n:
            activePrimes.append(inactivePrimes.pop(0))
            isPrime=False

        if isPrime:
            inactivePrimes.append(Prime(n))
            if (num % n) == 0:
                return n
    return num


