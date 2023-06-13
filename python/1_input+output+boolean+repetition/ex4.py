# -*- coding: utf-8 -*-
"""
Created on Thu Jun  8 11:26:12 2023

@author: Norah Lu
"""

# input
cycling = float(input('Enter hours cycling: '))
running = float(input('Enter hours running: '))
swimming = float(input('Enter hours swimming: '))

# calculation
calories = cycling*200 + running*475 + swimming*275
pounds_lost = calories/3500

# output
print('Total pounds lost: {0:.1f}'.format(pounds_lost))
