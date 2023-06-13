# -*- coding: utf-8 -*-
"""
Created on Thu Jun  8 09:30:31 2023

@author: Norah Lu
"""

# input
mile = float(input('Enter miles: '))
yard = float(input('Enter yards: '))
foot = float(input('Enter feet: '))
inch = float(input('Enter inches: '))

# calculation
total_inch = 63360*mile + 36*yard + 12*foot + inch
total_cent = total_inch/0.3937
km = total_cent // 100000
rest_cent = total_cent % 100000
m = rest_cent // 100
rest_cent %= 100
cm = rest_cent

# output
print('The metric length is:')
print('{0:.0f} kilometers'.format(km))
print('{0:.0f} meters'.format(m))
print('{0:.1f} centimeters'.format(cm))
