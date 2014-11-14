#Copyright (C) 2014 Lief Swanson

#This program is free software; you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation; either version 2 of the License, or
#(at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

#Author: Lief Swanson
#URL: https://github.com/liefswanson

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


