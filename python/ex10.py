# -*- coding: utf-8 -*-
"""
Created on Sat Jun 10 15:54:40 2023

@author: Norah Lu
"""

# input
hour = float(input('Please enter the number of hours worked: '))
wage = float(input('Please enter the hourly wage: '))

# calculation
if hour > 40:
    gross = 40*wage + (hour-40)*wage*1.5
else:
    gross = hour*wage

# output
print('Gross pay is ${0:.2f}'.format(gross))
