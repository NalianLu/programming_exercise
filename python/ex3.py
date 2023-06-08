# -*- coding: utf-8 -*-
"""
Created on Thu Jun  8 09:49:23 2023

@author: Norah Lu
"""

# inpuut
deposit_annual = float(input('Enter annual deposit: '))
rate_int = float(input('Enter rate: '))

# calculation
balance = deposit_annual*((1+rate_int/100)+(1+rate_int/100)**2+(1+rate_int/100)**3)  # 3 year, compounded annually

# output
print('After 3 years, balance is: ${0:.2f}'.format(balance))
