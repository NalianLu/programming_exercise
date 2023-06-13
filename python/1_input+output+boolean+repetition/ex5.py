#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun  5 21:24:55 2023

@author: Norah Lu
"""

# input
beginning = int(input('Enter beginning odometer: '))
ending = int(input('Enter ending odometer: '))
gallons = int(input('Enter gallons: '))

# calculation
efficiency = (ending - beginning)/gallons

# output
print('Fuel efficiency: {0:.1f} miles per gallon'.format(efficiency))
