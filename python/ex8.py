# -*- coding: utf-8 -*-
"""
Created on Sat Jun 10 15:39:01 2023

@author: Norah Lu
"""

# input
year = int(input('Enter year: '))

# calculation

if year % 400 == 0:
    print('{} is a leap year'.format(year))
elif year % 4 == 0 and year % 100 != 0:
    print('{} is a leap year'.format(year))
else:
    print('{} is not a leap year'.format(year))
