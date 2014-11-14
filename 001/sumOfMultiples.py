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
