# -*- coding: utf-8 -*-
"""
Created on Sat Jun 10 15:46:04 2023

@author: Norah Lu
"""

# input
military = int(input('Enter military time: '))

# calculation
hour = military // 100
minute = military % 100

if hour > 12:
    hour = hour-12
    print('{0:d}:{1:d}pm'.format(hour, minute))
elif hour == 12:
    print('{0:d}:{1:d}pm'.format(hour, minute))
elif 0 < hour < 12:
    print('{0:d}:{1:d}am'.format(hour, minute))
else:
    hour = hour+12
    print('{0:d}:{1:d}am'.format(hour, minute))
