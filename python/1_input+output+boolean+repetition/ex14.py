# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 08:39:18 2023

@author: Norah Lu
"""
# package
import math

# input
a = int(input('Enter the value for a:'))
b = int(input('Enter the value for b:'))
c = int(input('Enter the value for c:'))

# calculation & output
if b**2-4*a*c > 0:
    x1 = (-b+math.sqrt(b**2-4*a*c))/(2*a)
    x2 = (-b-math.sqrt(b**2-4*a*c))/(2*a)
    print('Solution: {0:.2f}, {1:.2f}'.format(x1, x2))
elif b**2-4*a*c == 0:
    x = (-b)/(2*a)
    print('Solution: {0:.2f}'.format(x))
else:
    print('No solutions.')
