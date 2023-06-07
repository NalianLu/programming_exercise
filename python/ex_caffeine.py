# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 10:36:46 2023

@author: Norah Lu
"""

caffeine = int(input('Enter caffeine (mg): '))
hour = int(input('Enter hours: '))

print('')
print('Hour  Caffeine')
print('----  --------')

for h in range(hour + 1):
    print('{0:4d}  {1:8.1f}'.format(h, caffeine))
    caffeine *= .87  # The body eliminates 13% per hour
