# -*- coding: utf-8 -*-
"""
Created on Thu Jun  8 11:27:42 2023

@author: Norah Lu
"""

# input
v0 = int(input('Enter initial velocity (fps): '))
h0 = int(input('Enter initial height (feet): '))

# calculation
t = 3  # after 3 seconds
h = -16*t**2 + v0*t + h0

# output
print('The height after {0} seconds is: {1:.1f} ft'.format(t, h))
