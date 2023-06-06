# -*- coding: utf-8 -*-
"""
Created on Mon Jun  5 15:33:47 2023

@author: Group 2
"""

# input
initial = float(input('Please enter your initial investment: '))
annual_interest = float(input('Please enter annual interest rate (ex. 2.5): '))
monthly_payout = float(input('Please enter the monthly annuity payout: '))

# initialize
balance = initial
month = 0

# calculation
while balance >= monthly_payout:
    total = balance*(1+annual_interest/100/12)
    balance = total - monthly_payout
    month += 1

print('After {0:.0f} months your balance is {1:.2f}.'.format(month, balance))