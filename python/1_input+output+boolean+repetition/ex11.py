# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 08:57:02 2023

@author: Norah Lu
"""

n = int(input('Please enter the maximum denominator: '))

sum = 0  # initialize

while n > 0:
    sum = sum+(1/n)
    n -= 1

print('The sum is {0}.'.format(sum))
