# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 10:58:05 2023

@author: Norah Lu
"""

year = int(input('Ending year: '))

while year < 2012:
    year = int(input('Ending year: '))

# initialize
year_0 = 2012
num = 80.0

# print headings
print('Year', 'Quantity', 'Price')
print('----', '--------', '-----')

# calculation & output
for year_i in range(year_0, year+1):
    price_i = 20 - 0.1 * num
    print('{0:4d} {1:8.1f} {2:5.2f}'.format(year_i, num, price_i))
    num = 5 * price_i - 10
