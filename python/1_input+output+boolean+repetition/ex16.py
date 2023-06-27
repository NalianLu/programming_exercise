# -*- coding: utf-8 -*-
"""
Created on Mon Jun 26 13:30:38 2023

@author: Norah Lu
"""

# user input
year_0 = int(input('Beginning year: '))
level_0 = float(input('Beginning level (ft): '))  # in ft
inflow_0 = float(input('Annual inflow (MAF): '))  # in MAF
change_0 = float(input('Annual flow change (MAF): '))  # in MAF

# setting
dead_pool = 895  # in ft

# unit change
outflow = 9.5  # in MAF
net_outflow = inflow_0 - outflow  # in MAF
net_outflow_ft = net_outflow/0.053  # in ft
change_0 = change_0/0.053  # in ft

# initialize
year = year_0
begin = level_0
change = net_outflow_ft
end = begin + change


if change_0 < 0:
    # print header
    print()
    print('Year Begin (ft) Change (ft) End (ft)')
    print('---- ---------- ----------- --------')
    print('{:4d} {:10.1f} {:11.1f} {:8.1f}'.format(year, begin, change, end))
    while end > dead_pool:
        year += 1
        begin = end
        change += change_0
        end = begin + change
        print('{:4d} {:10.1f} {:11.1f} {:8.1f}'.format(year, begin, change, end))

elif change_0 > 0:
    # print header
    print()
    print('Year Begin (ft) Change (ft) End (ft)')
    print('---- ---------- ----------- --------')
    print('{:4d} {:10.1f} {:11.1f} {:8.1f}'.format(year, begin, change, end))
    while change < 0:
        year += 1
        begin = end
        change += change_0
        end = begin + change
        if change < 0:
            print('{:4d} {:10.1f} {:11.1f} {:8.1f}'.format(year, begin, change, end))

else:
    print('Water level will never reach dead pool.')
