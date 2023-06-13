# -*- coding: utf-8 -*-
"""
Created on Thu Jun  8 11:26:32 2023

@author: Norah Lu
"""

# input
t1 = int(input('Enter time 1 hours: '))
m1 = int(input('Enter time 1 minutes: '))
t2 = int(input('Enter time 2 hours: '))
m2 = int(input('Enter time 2 minutes: '))

# calculation
total_time_in_minutes = t1*60 + m1 + t2*60 + m2
hours = total_time_in_minutes//60
minutes = total_time_in_minutes % 60

# output
print('Total time is {0}:{1}'.format(hours, minutes))
