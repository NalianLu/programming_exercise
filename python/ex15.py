# -*- coding: utf-8 -*-
"""
Created on Mon Jun  5 15:49:52 2023

@author: Group 2
"""

# input
item = input('Description of the item: ')
cost = float(input('Cost of the item: '))
life = float(input('Estimated life of the item in whole years: '))
method = int(input('Depreciation method (1 = straight line, 2 = double declining balance): '))

# initialize
year = 0
begin = cost
dep = 0
end = begin-dep

# openning
print('Depreciation schedule for:', item)
print('Year', 'Begin  ', 'Dep    ', 'End    ')
print('{0:<} {1:<.2f} {2:<.2f} {3:<.2f}'.format(year, begin, dep, end))

# calculation
if method == 1:
    dep = cost/life
    while year < life:
        end = begin-dep
        year += 1
        print('{0:<} {1:<.2f} {2:<.2f} {3:<.2f}'.format(year, begin, dep, end))
        begin = end
elif method == 2:
    while year < life-1:
        dep = 2*begin/life
        end = begin-dep
        year += 1
        print('{0:<} {1:<.2f} {2:<.2f} {3:<.2f}'.format(year, begin, dep, end))
        begin = end
    # last year
    year += 1
    dep = begin
    end = begin-dep
    print('{0:<} {1:<.2f} {2:<.2f} {3:<.2f}'.format(year, begin, dep, end))
