# -*- coding: utf-8 -*-
"""
Created on Wed Jun  7 21:58:05 2023

@author: Norah Lu
"""

# input
name = input('Please enter customer name: ')
hours = float(input('Please enter labor hours: '))
cost_parts = float(input('Please enter cost of parts and supplies: '))

# calculation
cost_labor = 35*hours  # bill customer at a rate of $35 per hour
cost_parts *= 1.07  # 7% sales tax
cost = cost_labor + cost_parts

# output
print('Customer: {0}'.format(name))
print('Labor cost: {0:.2f}'.format(cost_labor))
print('Parts cost: {0:.2f}'.format(cost_parts))
print('Total cost: {0:.2f}'.format(cost))
